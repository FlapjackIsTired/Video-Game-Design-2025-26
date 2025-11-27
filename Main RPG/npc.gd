extends CharacterBody2D

func _ready() -> void:
	$"../Player".interacted.connect(dialogue)
	
func dialogue(interactable):
	if interactable == $"Interact Box":
		print("hello")
