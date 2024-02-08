extends Panel

@onready var target_input = $target_input
@onready var source_input = $source_input


func _on_save_word_pressed():
	var word_to_add = VocabularyWord.new(target_input.text, source_input.text)
	VocabularyManager.add_words([word_to_add])
	target_input.clear()
	source_input.clear()
	target_input.grab_focus()
