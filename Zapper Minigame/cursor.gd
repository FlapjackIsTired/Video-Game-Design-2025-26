extends Area2D

signal shot

@onready var particles: CPUParticles2D = $Particles

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = get_global_mouse_position()
	
	if Input.is_action_just_pressed("space"):
		particles.emitting = true
		
		var bottles = get_overlapping_areas()
		if bottles.size() != 0:
			shot.emit(bottles[0].points)
			bottles[0].queue_free()
		else:
			shot.emit(-5)
