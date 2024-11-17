extends Control

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn") 
	
func _on_to_leitner_system_pressed():
	get_tree().change_scene_to_file("res://scenes/leitner_viewer.tscn") 

func _on_to_simple_queue_pressed():
	get_tree().change_scene_to_file("res://scenes/SimpleQueue.tscn") 

func _on_to_card_manager_pressed():
	get_tree().change_scene_to_file("res://scenes/card_management.tscn") 
