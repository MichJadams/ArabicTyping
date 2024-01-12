extends LearningSystem


class_name SimpleQueueSystem 

func _ready():
	todays_boxes_and_selected_card_count = get_todays_box_indexes()
	set_words_for_this_session()

func get_todays_box_indexes():
	todays_boxes_and_selected_card_count = {
		"uncategorized": 0 
	}
	var session_number = str(MetaStatisticsManager.get_session_number())
	for box_index_name in Constants.box_names_order:
		if box_index_name.contains(session_number):
			todays_boxes_and_selected_card_count[box_index_name] = 0 
	return todays_boxes_and_selected_card_count
	
func get_words_for_this_session():
	return words_for_this_session
	
func set_words_for_this_session():
	words_for_this_session = []
	var words = VocabularyManager.get_all_words()
	for word in words:
		if not word is VocabularyWord:
			break
		if words_for_this_session.size() >= 10:
			break
		var leitnerIndexString = Constants.box_names_order[word.leitnerIndex]
		if leitnerIndexString in todays_boxes_and_selected_card_count:
			if todays_boxes_and_selected_card_count[leitnerIndexString] <= 3:
				todays_boxes_and_selected_card_count[leitnerIndexString] += 1 
				words_for_this_session.append(word)
			else: 
				continue
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
