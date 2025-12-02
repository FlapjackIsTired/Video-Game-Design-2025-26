extends Node2D

@onready var time_label: Label = $"Time Label"
@onready var lives_left_label: Label = $"Lives Left Label"
@onready var reset_timer: Timer = $"Reset Timer"
@onready var slinky_player: CharacterBody2D = $"Slinky Player"

var ball_1 #= "res://Slinky Game/ball_1.tscn"
var ball_2 #= "res://Slinky Game/ball_2.tscn"
var all_balls = []

var time_survived = 0
var lives_left = 3

func _ready() -> void:
	ball_1 = load("res://Slinky Game/ball_1.tscn")
	ball_1 = ball_1.instantiate()
	add_child(ball_1)
	ball_1.position = Vector2(-128, -48)
	ball_1.freeze = true
	all_balls.append(ball_1)

func _process(delta: float) -> void:
	if reset_timer.is_stopped() == true:
		time_label.text = str(time_survived)
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
	#This will reset the balls position to give the player some tiem to recover
	lives_left -= 1
	for i in all_balls:
		i.freeze = true
		reset_timer.start()
		
	#ball_1 = get_node("Ball 1")
	#ball_1.freeze = true
	#reset_timer.start()
	

func _on_reset_timer_timeout() -> void:
	for i in all_balls:
		i.freeze = false
		i.apply_impulse(i.initial_velocity)
