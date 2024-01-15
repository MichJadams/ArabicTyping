extends Control

@export var leitnerSystem: LeitnerSystem = LeitnerSystem.new()
 
signal remove_word(box_index, display_word: DisplayWord) 
signal add_word(box_index, display_word: DisplayWord)

func _on_to_settings_pressed():
	get_tree().change_scene_to_file("res://scenes/settings.tscn") 

func _on_leitner_box_word_dropped(target_column_number, display_word:DisplayWord):
	var originating_column_index = LearningSystemsManager.get_column_index_given_word_id(display_word.word_id)
	var original_column_number = 0 
	remove_word.emit(originating_column_index, display_word)
	add_word.emit(target_column_number, display_word)
	LearningSystemsManager.promote_leitner_word_to_next_box(display_word.word_id, target_column_number)
