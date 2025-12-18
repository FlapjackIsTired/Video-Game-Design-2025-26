extends Node2D

@onready var time_label: Label = $"Time Label"
@onready var lives_left_label: Label = $"Lives Left Label"
@onready var high_score_screen: Control = $HighScoreScreen

@onready var reset_timer: Timer = $"Reset Timer"
@onready var slinky_player: CharacterBody2D = $"Slinky Player"

@onready var score_labels = [$HighScoreScreen/VBoxContainer/Score1,
$HighScoreScreen/VBoxContainer/Score2,
$HighScoreScreen/VBoxContainer/Score3,
$HighScoreScreen/VBoxContainer/Score4,
$HighScoreScreen/VBoxContainer/Score5]


var ball_1 #= "res://Slinky Game/ball_1.tscn"
var ball_2 #= "res://Slinky Game/ball_2.tscn"
var all_balls = []

var time_survived = 0
var lives_left = 3

func _ready() -> void:
	#I don't remeber why this is here, but the code doesn't work without it so ill figure that out later
	SaveLoad.load_save()
	
	ball_1 = load("res://Slinky Minigame/ball_1.tscn")
	ball_1 = ball_1.instantiate()
	add_child(ball_1)
	ball_1.position = Vector2(-128, -48)
	ball_1.freeze = true
	all_balls.append(ball_1)

func _process(delta: float) -> void:
	if reset_timer.is_stopped() == true:
		time_label.text = str(int(time_survived))
		time_survived += 0.02
	else:
		time_label.text = str(reset_timer.time_left)
	lives_left_label.text = str(lives_left)
	
	if time_survived >= 20 and ball_2 == null:
		ball_2 = load("res://Slinky Game/ball_2.tscn")
		ball_2 = ball_2.instantiate()
		add_child(ball_2)
		ball_2.position = Vector2(-128, -48)
		all_balls.append(ball_2)



func _on_slinky_player_lives_lost() -> void:
	#This will reset the balls position to give the player some time to recover
	lives_left -= 1
	for i in all_balls:
		if i != null:
			i.freeze = true
	
	if lives_left > 0:
		reset_timer.start()
	
	#This will be used to display what happens when the player dies
	elif lives_left == 0:
		for i in all_balls:
			i.queue_free()
		
		time_label.visible = false
		lives_left_label.visible = false
		reset_timer.paused = true
		high_score_screen.visible = true
		
		#adds the score to the array inside the SaveLoad script
		#Then it sorts it lowest to highest, and reverses it
		SaveLoad.save_file_data.slinky_scores.append(int(time_survived))
		SaveLoad.save_file_data.slinky_scores.sort()
		SaveLoad.save_file_data.slinky_scores.reverse()
		
		# We save this version of the score list, 
		# Then we load it immidietly to show the player their scores
		SaveLoad.save()
		SaveLoad.load_save()
		
		#Created a for loop to print the four highest scores
		#might create a highscore naming system later to make the game feel more like an arcade
		var count = 0
		
		for i in score_labels:
			#if SaveLoad.save_file_data.slinky_scores[count] != null
			if SaveLoad.save_file_data.slinky_scores.size() > count:
				i.text = str(SaveLoad.save_file_data.slinky_scores[count])
				print(str(SaveLoad.save_file_data.slinky_scores[count]))
			else:
				i.text += "none"
				
			count += 1

func _on_reset_timer_timeout() -> void:
	for i in all_balls:
		i.freeze = false
		i.apply_impulse(i.initial_velocity)
