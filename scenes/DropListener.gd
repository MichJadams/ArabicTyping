extends Panel

class_name LeitnerBox 

@export var box_index: int

signal add_words(box_index, words) 
signal word_dropped(box_index, word)

func _ready():
	var words = LearningSystemsManager.get_words_from_index(box_index)
	if words:
		add_words.emit(box_index, words)
	
func _can_drop_data(_pos, data):
	if data is VocabularyWord:
		return true
	return false
	
func _drop_data(_pos, data):
	if data is VocabularyWord:
		word_dropped.emit(box_index, data)
