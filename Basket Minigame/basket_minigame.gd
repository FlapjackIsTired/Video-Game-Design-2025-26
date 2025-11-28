extends Node2D

@onready var point_label: Label = $"Point Label"
@onready var time_label: Label = $"Time Label"
@onready var total_timer: Timer = $"Total Timer"
@onready var micro_timer: Timer = $"Micro Timer"

@export var curve : Curve

var items = ["res://Basket Minigame/apple.tscn", 
"res://Basket Minigame/banana.tscn"]
var total_points = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var count = 0
	for i in items:
		items[count] = load(i)
		count += 1



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	point_label.text = str(total_points)
	time_label.text = str(total_timer.time_left)
	micro_timer.wait_time = curve.sample(total_timer.time_left)

func _on_basket_player_points_collected(points) -> void:
	total_points += points


func _on_micro_timer_timeout() -> void:
	#Gonna design it so when we are 15 seconds in, it will drop one item
	#30 seconds in, it will drop two
	#45, it will drop three
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
		
	while count <= amount:
		count += 1
		var item = items[randi_range(0,1)].instantiate()
		add_child(item)
		item.position = Vector2(randf_range(-160, 160), -90)


func _on_total_timer_timeout() -> void:
	micro_timer.stop()
	GlobalVars.basket_scores.append(total_points)
	GlobalVars.basket_scores.sort()
	GlobalVars.basket_scores.invert()
	print(GlobalVars.basket_scores)
