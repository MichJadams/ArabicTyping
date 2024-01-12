extends Panel

class_name LeitnerBox 

@export var box_index: int

signal add_words(box_index, words) 
signal word_dropped(box_index, word)

func _ready():
	var words = LeitnerSystem.get_words_for_box_index(box_index)
	add_words.emit(box_index, words)
	
func _can_drop_data(_pos, data):
	if data is VocabularyWord:
		return true
	return false
	
func _drop_data(_pos, data):
	if data is VocabularyWord:
		word_dropped.emit(box_index, data)

func _on_control_add_word(box_index, word):
	pass # Replace with function body.
