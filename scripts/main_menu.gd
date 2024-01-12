extends Control

func _on_settings_button_pressed():
	get_tree().change_scene_to_file("res://scenes/settings.tscn") 
	
func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/practice.tscn")

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn") 

func _on_to_leitner_system_pressed():
	get_tree().change_scene_to_file("res://scenes/leitner_viewer.tscn") 
