extends Node2D

@onready var time_label: Label = $"Time Label"
@onready var total_timer: Timer = $"Total Timer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_label.text = str(total_timer.time_left)
