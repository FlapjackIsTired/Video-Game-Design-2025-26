extends CharacterBody2D

const speed = 100.0

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("a",
	"d",
	"w",
	"s")
	
	velocity = speed * direction
	
	move_and_slide()
