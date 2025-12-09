extends StaticBody2D

@onready var dialogue = load("res://slinky_cabinet_dialogue.dialogue")

func _ready() -> void:
	$"../Player".interacted.connect(start_dialogue)
	
func start_dialogue(interactable):
	if interactable == $"Interact Box":
		print("yay")
		DialogueManager.show_dialogue_balloon(dialogue)
		
func _process(delta: float) -> void:
	if DialogueVariables.start_game == true:
		get_tree().change_scene_to_file("res://Slinky Game/slinky_game.tscn")
