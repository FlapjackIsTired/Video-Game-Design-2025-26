extends Area2D

signal shot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = get_global_mouse_position()
	
	if Input.is_action_just_pressed("space"):
		var bottles = get_overlapping_areas()
		if bottles.size() != 0:
			shot.emit(bottles[0].points)
			bottles[0].queue_free()
		else:
			shot.emit(-5)
