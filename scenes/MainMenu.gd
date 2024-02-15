extends Control

func _on_to_settings_pressed():
	get_tree().change_scene_to_file("res://scenes/settings.tscn") 

func _on_to_practice_pressed():
	get_tree().change_scene_to_file("res://scenes/practice.tscn") 
