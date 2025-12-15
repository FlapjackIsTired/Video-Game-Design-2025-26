extends CharacterBody2D






'''
const tile_size = 16

@onready var line_2d = $Line2D
@onready var tilemap_layer = $"../Grass Placeholder"
@onready var player = $"../Player"

var pathfinding_grid = AStarGrid2D.new()
var path_to_player = []

 
func _ready() -> void:
	pathfinding_grid.region = tilemap_layer.get_used_rect()
	pathfinding_grid.cell_size = Vector2(tile_size, tile_size)
	pathfinding_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	pathfinding_grid.update()
	
	for cell in tilemap_layer.get_used_cells():
		pathfinding_grid.set_point_solid(cell,false)

#func _process(delta: float) -> void:
	#path_to_player = pathfinding_grid.grid.get_point_path(global_position / tile_size, player.global_position / tile_size)


func _on_move_timer_timeout() -> void:
	path_to_player = pathfinding_grid.get_point_path(global_position / tile_size, player.global_position / tile_size)
	line_2d.points = path_to_player
	if path_to_player.size() > 1:
		print("moved")
		path_to_player.remove_at(0)
		var go_to_pos: Vector2 = path_to_player[0] + Vector2(tile_size/2.0, tile_size/2.0)
		
		global_position = go_to_pos
'''
