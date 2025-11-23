extends CharacterBody2D

const speed = 100.0

@onready var raycast = $"Interaction Raycast"
var direction = Vector2.ZERO

signal interacted

func _physics_process(delta: float) -> void:
	
	var last_dir = []
	
	direction = Input.get_vector("a",
	"d",
	"w",
	"s")
	
	if Input.is_anything_pressed() == true:
		last_dir.append(direction)
		raycast.target_position = Vector2(last_dir.get(0).x * 50, last_dir.get(0).y * 50)
	
	
	if Input.is_action_just_pressed("space") == true:
		var interactable = raycast.get_collider()
		if interactable != null:
			emit_signal("interacted", interactable)
	
	velocity = speed * direction
	
	move_and_slide()
