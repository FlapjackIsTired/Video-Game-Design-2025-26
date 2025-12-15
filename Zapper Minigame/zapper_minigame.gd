extends Node2D

@onready var micro_timer: Timer = $"Micro Timer"
@onready var total_timer: Timer = $"Total Timer"
@onready var spawn_locations = [$"Top Row/Spot 1",
$"Top Row/Spot 2", 
$"Top Row/Spot 3",
$"Top Row/Spot 4",
$"Middle Row/Spot 5",
$"Middle Row/Spot 6", 
$"Middle Row/Spot 7", 
$"Middle Row/Spot 8",
$"Bottom Row/Spot 9", 
$"Bottom Row/Spot 10", 
$"Bottom Row/Spot 11", 
$"Bottom Row/Spot 12"]

@export var curve : Curve

var items = ["res://Zapper Minigame/cowboy.tscn"]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(items)
	var count = 0
	for i in items:
		items[count] = load(i)
		count += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	micro_timer.wait_time = curve.sample(total_timer.time_left)


func _on_micro_timer_timeout() -> void:
	var amount = 1
	var count = 0
	if total_timer.time_left <= 50:
		amount = 2
	elif total_timer.time_left <= 40:
		amount = 3
	elif total_timer.time_left <= 30:
		amount = 5
	elif total_timer.time_left <= 20:
		amount = 6
	
	var current_items = []
	
	while count < amount:
		var item = items[0].instantiate()
		var spawn_spot = spawn_locations[randi_range(0,11)].global_position
		current_items.append(item)
		
		for i in current_items:
			if spawn_spot == i.global_position:
				spawn_spot = spawn_locations[randi_range(0,11)].global_position
		
		add_child(item)
		
		item.position = spawn_spot
		count += 1


func _on_total_timer_timeout() -> void:
	pass
