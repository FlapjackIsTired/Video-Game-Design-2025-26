extends CharacterBody2D

signal lives_lost

@onready var invuln_timer: Timer = $"Invulnerability Timer"
@onready var area_2d: Area2D = $Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var label: Label = $Label

var is_hit = false

const speed = 200.0
const jump_velocity = -250.0

func _physics_process(delta: float) -> void:
	
	if is_hit == true:
		area_2d.collision_mask = 15
		sprite_2d.modulate = Color.BLUE
		label.text = str(int(invuln_timer.time_left)+1)
	else:
		area_2d.collision_mask = 2
		sprite_2d.modulate = Color.WHITE
		label.text = ""
		
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("space") and is_on_floor():
		velocity.y = jump_velocity

	var direction := Input.get_axis("a", "d")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	lives_lost.emit()
	if is_hit == false:
		is_hit = true
		invuln_timer.start()


func _on_invulnerability_timer_timeout() -> void:
	is_hit = false
