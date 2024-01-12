extends Control

signal remove_word(box_index, word) 
signal add_word(box_index, word)

func _on_to_settings_pressed():
	get_tree().change_scene_to_file("res://scenes/settings.tscn") 

func _on_leitner_box_word_dropped(target_box_index, word:VocabularyWord):
	remove_word.emit(word.leitnerIndex, word)
	word.set_leitner_index(target_box_index)
	add_word.emit(target_box_index, word)
	var test = VocabularyManager.get_all_words()
	VocabularyManager.save_vocabulary()
