extends LearningSystem

class_name SimpleQueueSystem 

func get_words_for_this_session():
	var word_ids_for_this_session = LearningSystemsManager.get_simple_queue_words()
	var words_for_this_session = []
	for word_id in word_ids_for_this_session:
		words_for_this_session.append(VocabularyManager.get_word_by_id(word_id))
	return words_for_this_session
	
func word_score(word_id):
	pass  

func increment_session():
	pass

func promote_word(word_id):
	pass
