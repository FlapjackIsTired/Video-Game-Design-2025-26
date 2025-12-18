extends Area2D

signal spot_shared


@onready var death_timer: Timer = $"Death Timer"

@export var stats : Resource

var points
var is_solo = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	points = stats.value
	death_timer.start(stats.survival_time + randf_range(0, 0.5))
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var time_left_flipped = death_timer.wait_time - death_timer.time_left
	
	scale = Vector2(stats.curve.sample(death_timer.wait_time - death_timer.time_left),
	stats.curve.sample(death_timer.wait_time - death_timer.time_left))
	
	#print(curve.sample(death_timer.wait_time - death_timer.time_left))


func _on_death_timer_timeout() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	is_solo = false
	spot_shared.emit(get_node("."), get_overlapping_areas()[0])
