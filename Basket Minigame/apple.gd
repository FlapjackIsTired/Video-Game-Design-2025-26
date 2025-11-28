extends Area2D

@export var stats : Resource

var fall_speed
var value

func _ready() -> void:
	value = stats.value
	fall_speed = stats.fall_speed

func _process(delta: float) -> void:
	position += Vector2(0, fall_speed/10)

func _on_body_entered(body: Node2D) -> void:
	queue_free()
