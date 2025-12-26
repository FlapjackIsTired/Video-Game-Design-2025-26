extends Node2D


#gonna use this code to make a random high score list every time, not yet tho

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if SaveLoad.save_file_data.first_time_playing == false:
		SaveLoad.save_file_data.basket_scores = [750, 700, 600, 300, 0]
		SaveLoad.save_file_data.slinky_scores = [45, 40, 30, 20, 1]
		SaveLoad.save_file_data.zapper_scores = [0,0,0,0,0]
		
		SaveLoad.save_file_data.first_time_playing = true
		
		SaveLoad.save()
		SaveLoad.load_save()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
