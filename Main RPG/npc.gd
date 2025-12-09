extends CharacterBody2D

@onready var dialogue = load("res://Main RPG/first_npc_dialogue.dialogue")

func _ready() -> void:
	$"../Player".interacted.connect(start_dialogue)
	
func start_dialogue(interactable):
	if interactable == $"Interact Box":
		DialogueManager.show_dialogue_balloon(dialogue)
