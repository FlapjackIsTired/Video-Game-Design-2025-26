extends RigidBody2D

@export var stats : Resource

@onready var right_area: Area2D = $"Right Area"
@onready var left_area: Area2D = $"Left Area"

@onready var initial_velocity = stats.initial_velocity
@onready var min_speed = stats.min_speed
@onready var max_speed = stats.max_speed
@onready var reset_position = stats.reset_position

var current_speed

func _ready() -> void:
	#var initial_velocity = stats.initial_velocity
	#var min_speed = stats.min_speed
	#var max_speed = stats.max_speed
	
	apply_impulse(initial_velocity)

func _physics_process(delta: float) -> void:
	#this is here to prevent a physics issue where the ball bounces
	#twice and loses a ton of momentum. this keeps its speed consistent
	if current_speed != null and freeze == false:
		linear_velocity.x = current_speed
	elif freeze == true:
		linear_velocity = Vector2(0,0)
		position = reset_position


func _on_right_area_body_entered(body: Node2D) -> void:
	#Resets linear velocity to keep movement consistent, 
	#then applies a force to keep the ball moving
	
	linear_velocity.x = 0
	current_speed = randi_range(-min_speed,-max_speed)
	apply_impulse(Vector2(current_speed,0))

func _on_left_area_body_entered(body: Node2D) -> void:
	linear_velocity.x = 0
	current_speed = randi_range(min_speed,max_speed)
	apply_impulse(Vector2(current_speed,0))
