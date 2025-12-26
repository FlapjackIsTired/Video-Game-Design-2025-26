extends Node2D

@onready var point_label: Label = $"Point Label"
@onready var time_label: Label = $"Time Label"
@onready var total_timer: Timer = $"Total Timer"
@onready var micro_timer: Timer = $"Micro Timer"

@onready var high_score_screen: Control = $HighScoreScreen

@onready var score_labels = [$HighScoreScreen/VBoxContainer/Score1, 
$HighScoreScreen/VBoxContainer/Score2, 
$HighScoreScreen/VBoxContainer/Score3, 
$HighScoreScreen/VBoxContainer/Score4, 
$HighScoreScreen/VBoxContainer/Score5]

@export var curve : Curve

var items = ["res://Basket Minigame/apple.tscn", 
"res://Basket Minigame/banana.tscn"]
var total_points = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SaveLoad.load_save()
	
	var count = 0
	for i in items:
		items[count] = load(i)
		count += 1



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	point_label.text = str(total_points)
	time_label.text = str(int(total_timer.time_left))
	micro_timer.wait_time = curve.sample(total_timer.time_left)

func _on_basket_player_points_collected(points) -> void:
	total_points += points


func _on_micro_timer_timeout() -> void:
	#Gonna design it so when we are 15 seconds in, it will drop one item
	#30 seconds in, it will drop two
	#45, it will drop three
	var amount = 1
	var count = 0
	if total_timer.time_left <= 50 and total_timer.time_left >= 40:
		amount = 2
	elif total_timer.time_left <= 40 and total_timer.time_left >= 30:
		amount = 3
	elif total_timer.time_left <= 30 and total_timer.time_left >= 20:
		amount = 5
	elif total_timer.time_left <= 20:
		amount = 6
		
	while count <= amount:
		count += 1
		var item = items[randi_range(0,1)].instantiate()
		add_child(item)
		item.position = Vector2(randf_range(-160, 160), -90)


func _on_total_timer_timeout() -> void:
	micro_timer.stop()
	
	if total_points > SaveLoad.save_file_data.basket_scores[0]:
		SaveLoad.save_file_data.basket_completed = true
		print("good jorb, you completed the absket minigame")
	
	
	SaveLoad.save_file_data.basket_scores.append(total_points)
	SaveLoad.save_file_data.basket_scores.sort()
	SaveLoad.save_file_data.basket_scores.reverse()
	
	SaveLoad.save_file_data.basket_scores.get(total_points)
	
	SaveLoad.save()
	SaveLoad.load_save()
	
	high_score_screen.visible = true
	
	
	
	var count = 0
	var count2 = 0
	
	var player_score
	
	for i in SaveLoad.save_file_data.basket_scores:
		if i == total_points:
			player_score = count2
			break
		count2 += 1
	
	for i in score_labels:
		#if SaveLoad.save_file_data.slinky_scores[count] != null
		if SaveLoad.save_file_data.basket_scores.size() > count:
			i.text = str(SaveLoad.save_file_data.basket_scores[count])
			if count == player_score:
				i.modulate = Color.GREEN
		else:
			i.text += "none"
			
		count += 1
	
