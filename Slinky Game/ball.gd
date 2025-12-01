extends RigidBody2D

@export var stats : Resource

@onready var right_area: Area2D = $"Right Area"
@onready var left_area: Area2D = $"Left Area"

func _ready() -> void:
	apply_impulse(Vector2(-100,0))

func _on_right_area_body_entered(body: Node2D) -> void:
	#Resets linear vlocity to keep movement consistent, 
	#then applies a force to keep the ball moving
	print("right")
	linear_velocity.x = 0
	apply_impulse(Vector2(randi_range(-200,-250),0))

func _on_left_area_body_entered(body: Node2D) -> void:
	print("left")
	linear_velocity.x = 0
	apply_impulse(Vector2(randi_range(200,250),0))
