extends Resource 
class_name SavedVocabulary

@export var words = [] 
@export var words_by_id = {}

func add_word(word:VocabularyWord):
	if word == null:
		return false 
	if word.id in words_by_id:
		return false 
	words_by_id[word.id] = word 
	words.append(word)
	return true 

func remove_word(word:VocabularyWord):
	if word.id in words_by_id:
		words_by_id.erase(word.id)
	else:
		return false 
	var index = words.find(word)
	if index >= 0:
		words.remove_at(index)
	else: 
		return false 
	return true 
