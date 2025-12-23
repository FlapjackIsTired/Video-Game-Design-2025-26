extends StaticBody2D

@export var dialogue : String
@export var game_path : String

var loaded_dialogue

func _ready() -> void:
	$"../Player".interacted.connect(start_dialogue)
	DialogueManager.dialogue_ended.connect(start_game)
	loaded_dialogue = load(dialogue)
	
func start_dialogue(interactable):
	if interactable == $"Interact Box":
		DialogueManager.show_dialogue_balloon(loaded_dialogue)

func start_game(ended_dialogue) -> void:
	if ended_dialogue == loaded_dialogue and DialogueVariables.start_game == true:
		get_tree().change_scene_to_file(game_path)
