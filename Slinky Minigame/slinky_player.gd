extends CharacterBody2D

signal lives_lost

const speed = 200.0
const jump_velocity = -250.0

func _physics_process(delta: float) -> void:
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
