extends Area2D

@onready var death_timer: Timer = $"Death Timer"

@export var stats : Resource
@export var curve : Curve

var points
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#death_timer.wait_time = stats.survival_time
	points = stats.value
	curve.max_domain = death_timer.wait_time
	death_timer.start(stats.survival_time)
	#curve.get_point_position(2).x = death_timer.wait_time


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#var time_left_flipped = death_timer.wait_time - death_timer.time_left
	
	scale = Vector2(curve.sample(death_timer.wait_time - death_timer.time_left), 
	curve.sample(death_timer.wait_time - death_timer.time_left))


func _on_death_timer_timeout() -> void:
	print("dead")
	queue_free()
