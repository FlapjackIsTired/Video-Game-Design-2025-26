extends CharacterBody2D

signal points_collected(points)

const speed = 200.0
const jump_velocity = -250.0

@onready var basket: Area2D = $Basket


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("space") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("a", "d")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

func _on_basket_area_entered(area: Area2D) -> void:
	var items = basket.get_overlapping_areas()
	var points
	for i in items:
		if i != null:
			points = i.value
			points_collected.emit(points)
			i.queue_free()
