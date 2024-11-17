extends Control

@onready var api_input: TextEdit = $VBoxContainer/api_input

var api_key = ""

func _on_api_input_focus_exited() -> void:
	#api_key = api_input.text; 
	#print(api_key)
	pass
