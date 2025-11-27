extends Node2D

@onready var label: Label = $Label

var total_points = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = str(total_points)


func _on_basket_player_points_collected(points) -> void:
	total_points += points
