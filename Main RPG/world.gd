extends Node2D

@export var final_dialogue : String
#gonna use this code to make a random high score list every time, not yet tho
var loaded_dialogue

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SaveLoad.load_save()
	loaded_dialogue = load(final_dialogue)
	
	print(SaveLoad.save_file_data.first_time_playing)
	if SaveLoad.save_file_data.first_time_playing == false:
		SaveLoad.save_file_data.basket_scores = [0,0,0,0,0]#[750, 700, 600, 300, 0]
		SaveLoad.save_file_data.slinky_scores = [0,0,0,0,0]#[45, 40, 30, 20, 1]
		SaveLoad.save_file_data.zapper_scores = [0,0,0,0,0]
	
	#if SaveLoad.save_file_data.first_time_playing == false:
	#SaveLoad.save_file_data.basket_scores = [0,0,0,0,0]#[750, 700, 600, 300, 0]
	#SaveLoad.save_file_data.slinky_scores = [0,0,0,0,0]#[45, 40, 30, 20, 1]
	#SaveLoad.save_file_data.zapper_scores = [0,0,0,0,0]
	
	
	SaveLoad.save_file_data.first_time_playing = true
	
	SaveLoad.save()
	SaveLoad.load_save()
	
	print(SaveLoad.save_file_data.basket_scores)
	print(SaveLoad.save_file_data.slinky_scores)
	print(SaveLoad.save_file_data.zapper_scores)
	print(SaveLoad.save_file_data.first_time_playing)
	
	if SaveLoad.save_file_data.basket_completed == true and SaveLoad.save_file_data.zapper_completed == true and SaveLoad.save_file_data.slinky_completed == true:
		DialogueManager.show_dialogue_balloon(loaded_dialogue)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
