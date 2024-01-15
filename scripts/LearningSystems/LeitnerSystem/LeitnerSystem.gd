extends LearningSystem

class_name LeitnerSystem
	
func increment_session():
	LearningSystemsManager.increment_leitner_session_number()

func promote_word(word_id: String):
	LearningSystemsManager.promote_leitner_word_to_next_box(word_id)
	
func get_todays_box_names():
	var session_number = LearningSystemsManager.get_leitner_session_number()
	return given_session_get_boxes(session_number)

func given_session_get_boxes(session_number: int):
	var session_string = str(session_number)
	var box_names = []
	var all_box_names = LearningSystemsManager.get_all_leitner_box_names()
	for box_name in all_box_names:
		if box_name.contains(session_string):
			box_names.append(box_name)
	return box_names

func load_uncategorized_boxes():
	LearningSystemsManager.load_uncategorized_leitner_boxes()
	
func get_words_for_this_session():
	var words_for_this_session = []
	var todays_boxes = get_todays_box_names()
	var word_ids_for_this_session = LearningSystemsManager.given_box_names_get_slice_of_words(todays_boxes, 2)
	
	if word_ids_for_this_session.size() <= 10:
		word_ids_for_this_session = LearningSystemsManager.get_uncategorized_word_ids()
	
	for word_id in word_ids_for_this_session:
		words_for_this_session.append(VocabularyManager.get_word_by_id(word_id))
	return words_for_this_session

func remove_word(word_id):
	LearningSystemsManager.remove_word_from_leitner_system(word_id)
	
#func get_box_index_given_word_id(word_id):
	#var current_box = ""
	#var current_box_index = -1 
	#for box_name in LearningSystemsManager.get_all_leitner_box_names():
		#var word_ids = LearningSystemsManager.given_box_names_get_slice_of_words(box_name)
		#var word_index = word_ids.find(word_id)
		#if word_index == -1: 
			#continue 
		#else:
			#current_box = box_name 
			#current_box_index = word_index 
			#break
	#var next_box_name = learningSystemsData.get_next_box_name(current_box) if next_box == null else learningSystemsData.leitner_box_names_order[next_box]
		#
	#learningSystemsData.leitner_box_number_to_words[current_box].remove_at(current_box_index)
	#learningSystemsData.leitner_box_number_to_words[next_box_name].append(word_id)
