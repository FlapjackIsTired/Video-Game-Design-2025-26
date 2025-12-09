extends Node

const save_location = "user://save_file.tres"

var save_file_data : SaveData = SaveData.new()

func save():
	ResourceSaver.save(save_file_data, save_location)
	

func load_save():
	if FileAccess.file_exists(save_location):
		save_file_data = ResourceLoader.load(save_location).duplicate(true)
