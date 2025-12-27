extends Control


func _on_reset_pressed() -> void:
	SaveLoad.load_save()
	#if SaveLoad.save_file_data.first_time_playing == false:
	SaveLoad.save_file_data.basket_scores = [0,0,0,0,0]#[750, 700, 600, 300, 0]
	SaveLoad.save_file_data.slinky_scores = [0,0,0,0,0]#[45, 40, 30, 20, 1]
	SaveLoad.save_file_data.zapper_scores = [0,0,0,0,0]
	
	
	SaveLoad.save_file_data.first_time_playing = false
	
	SaveLoad.save_file_data.basket_completed = false
	SaveLoad.save_file_data.slinky_completed = false
	SaveLoad.save_file_data.zapper_completed = false
	
	SaveLoad.save()
	SaveLoad.load_save()


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://UI Stuff/title_screen.tscn")
