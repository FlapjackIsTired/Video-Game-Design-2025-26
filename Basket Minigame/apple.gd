extends RigidBody2D

@export var stats : Resource
@onready var sprite_2d: Sprite2D = $Sprite2D

var fall_speed
var value

func _ready() -> void:
	value = stats.value
	fall_speed = stats.fall_speed

func _process(delta: float) -> void:
	apply_force(Vector2(0, fall_speed))

func _on_area_2d_body_entered(body: Node2D) -> void:
	queue_free()
