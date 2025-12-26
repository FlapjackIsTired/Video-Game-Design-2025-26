extends Control

@onready var score_labels = [$VBoxContainer/Score1, 
$VBoxContainer/Score2, 
$VBoxContainer/Score3, 
$VBoxContainer/Score4, 
$VBoxContainer/Score5]

var reset_score

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Main RPG/world.tscn")


func _on_clear_save_pressed() -> void:
	SaveLoad.save_file_data.basket_scores = [750, 700, 600, 300, 0]
	SaveLoad.save_file_data.slinky_scores = [45, 40, 30, 20, 1]
	
	
	SaveLoad.save()
	SaveLoad.load_save()
	
	var count = 0
	
	for i in score_labels:
	#if SaveLoad.save_file_data.slinky_scores[count] != null
		if SaveLoad.save_file_data.slinky_scores.size() > count:
			i.text = str(SaveLoad.save_file_data.slinky_scores[count])
			#print(str(SaveLoad.save_file_data.basket_scores[count]))
		else:
			i.text = "none"
			
		count += 1
