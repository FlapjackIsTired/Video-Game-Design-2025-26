extends Node2D

const wall_tile_coord = Vector2i(0,0)
const floor_tile_coord = Vector2i(1,0)
const tile_size = 16

var player
var enemy

var astar_grid = AStarGrid2D.new()
var path = []

#func _ready() -> void:
#	astar_grid.region = Vector2(tile_size, tile_size)
