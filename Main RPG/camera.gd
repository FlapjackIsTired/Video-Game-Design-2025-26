extends Camera2D

var player_pos

func _process(delta: float) -> void:
	player_pos = $"../Player".position
	position = player_pos
