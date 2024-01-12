extends LearningSystem

class_name LeitnerSystem
	
func _init():
	set_words_for_this_session()
	
func get_todays_box_names():
	var session_number = str(LearningSystemsManager.get_leitner_session_number())
	return given_session_get_boxes(session_number)

func given_session_get_boxes(session_number: String):
	var box_names = []
	var all_box_names = LearningSystemsManager.get_all_leitner_box_names()
	for box_name in all_box_names:
		if box_name.contains(session_number):
			box_names.append(box_name)
	return box_names

func load_uncategorized_boxes():
	LearningSystemsManager.load_uncategorized_leitner_boxes()
	
func set_words_for_this_session():
	var todays_boxes = get_todays_box_names()
	words_for_this_session = LearningSystemsManager.given_box_names_get_slice_of_words(todays_boxes, 2)
	
	if words_for_this_session.size() >= 10:
		return words_for_this_session 
		
	var words = LearningSystemsManager.get_uncategorized_words()
	for word in words:
		if not word is VocabularyWord:
			continue
		if words_for_this_session.size() >= 10:
			break
		words_for_this_session.append(word)
	return words_for_this_session

func is_session_over(session_word_index):
	if session_word_index >= words_for_this_session.size(): 
		return true 
	return false 
	
func increment_session():
	for word in words_for_this_session:
#		word.upgrade_card()
		word.leitnerIndex += 1 
	MetaStatisticsManager.update_session_number()
	VocabularyManager.save_vocabulary()
	
func get_next_word(session_word_index):
	if session_word_index < words_for_this_session.size():
		var current_word = words_for_this_session[session_word_index]
		session_word_index += 1 
		return current_word
	return words_for_this_session.front()

func get_words_for_box_index(index:int):
	var words = VocabularyManager.get_all_words()
	var returnWords = []
	for word in words:
		if word != null and word.leitnerIndex == index:
			returnWords.append(word)
	return returnWords


