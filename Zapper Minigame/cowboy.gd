extends Area2D

signal spot_shared

@onready var death_timer: Timer = $"Death Timer"

@export var stats : Resource
@export var curve : Curve

var points
var is_solo = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#death_timer.wait_time = stats.survival_time
	points = stats.value
	curve.max_domain = death_timer.wait_time
	death_timer.start(stats.survival_time)
	
	#curve.get_point_position(3).x = death_timer.wait_time
	#curve.add_point(Vector2(death_timer.wait_time/2, 0.75))
	#curve.add_point(Vector2(death_timer.wait_time, 0))
	#print(Vector2(death_timer.wait_time/2, 0.75))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#var time_left_flipped = death_timer.wait_time - death_timer.time_left
	
	#scale = Vector2(curve.sample(death_timer.wait_time - death_timer.time_left),
	#curve.sample(death_timer.wait_time - death_timer.time_left))
	
	#print(curve.sample(death_timer.wait_time - death_timer.time_left))


func _on_death_timer_timeout() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	is_solo = false
	spot_shared.emit(get_node("."), get_overlapping_areas()[0])
