extends Node2D



@onready var micro_timer: Timer = $"Micro Timer"
@onready var total_timer: Timer = $"Total Timer"
@onready var time_label: Label = $"Time Label"
@onready var score_label: Label = $"Score Label"
@onready var cursor: Area2D = $Cursor
@onready var high_score_screen: Control = $HighScoreScreen

@onready var score_labels = [$HighScoreScreen/VBoxContainer/Score1, 
$HighScoreScreen/VBoxContainer/Score2, 
$HighScoreScreen/VBoxContainer/Score3, 
$HighScoreScreen/VBoxContainer/Score4, 
$HighScoreScreen/VBoxContainer/Score5]

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

var items = ["res://Zapper Minigame/cowboy.tscn",
"res://Zapper Minigame/cowboy.tscn",
"res://Zapper Minigame/cowboy_2.tscn",
"res://Zapper Minigame/cowboy_2.tscn",
"res://Zapper Minigame/cactus.tscn"]
var total_points = 0
var current_items = []

var amount = 1

var times_called = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SaveLoad.load_save()
	
	var count = 0
	for i in items:
		items[count] = load(i)
		count += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	micro_timer.wait_time = curve.sample(total_timer.time_left)
	time_label.text = str(int(total_timer.time_left))


func _on_micro_timer_timeout() -> void:
	var count = 0
	
	if total_timer.time_left <= 50 and total_timer.time_left >= 35:
		amount = 2
	elif total_timer.time_left <= 35 and total_timer.time_left >= 20:
		amount = 4
	elif total_timer.time_left <= 20 and total_timer.time_left >= 0:
		amount = 5

	while count < amount:
		print("went")
		spawn_item()
		count += 1
	
	update_current_items()
	
	print(current_items)

func _on_total_timer_timeout() -> void:
	time_label.visible = false
	score_label.visible = false
	micro_timer.paused = true
	high_score_screen.visible = true
	
	#adds the score to the array inside the SaveLoad script
	#Then it sorts it lowest to highest, and reverses it
	SaveLoad.save_file_data.zapper_scores.append(total_points)
	SaveLoad.save_file_data.zapper_scores.sort()
	SaveLoad.save_file_data.zapper_scores.reverse()
	
	# We save this version of the score list, 
	# Then we load it immidietly to show the player their scores
	SaveLoad.save()
	SaveLoad.load_save()
	
	#Created a for loop to print the four highest scores
	#might create a highscore naming system later to make the game feel more like an arcade
	var count = 0
	
	for i in current_items:
		if i != null:
			i.queue_free()
	
	for i in score_labels:
		#if SaveLoad.save_file_data.slinky_scores[count] != null
		if SaveLoad.save_file_data.zapper_scores.size() > count:
			i.text = str(SaveLoad.save_file_data.zapper_scores[count])
			print(str(SaveLoad.save_file_data.zapper_scores[count]))
		else:
			i.text = "none"
			
		count += 1

func _on_cursor_shot(points) -> void:
	total_points += points
	score_label.text = str(total_points)

func fix_position(item1, item2):
	times_called += 1
	if times_called == 2:
		var old_position = item2.global_position
		if current_items.size() <= 12:
			while true:
				if old_position == item2.global_position:
					item2.global_position = spawn_locations[randi_range(0,11)].global_position
				else:
					item2.is_solo = true
					item1.is_solo = true
					break
			times_called = 0
		
		else:
			item2.queue_free()
			

func spawn_item():
	if current_items.size() <= 12:
		var item = items[randi_range(0,4)].instantiate()
		var spawn_spot = spawn_locations[randi_range(0,11)].global_position
			
		item.spot_shared.connect(fix_position)
		current_items.append(item)
		if item.is_solo == true:
			item.position = spawn_spot
			add_child(item)
			

func update_current_items():
	var count = 0
	for i in current_items:
		if i == null:
			print("die")
			current_items.remove_at(count)
		count += 1
