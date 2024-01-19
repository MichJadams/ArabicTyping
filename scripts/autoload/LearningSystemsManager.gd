extends Node

var location = "user://save/"
var learning_systems_file_name = "learningSystems.tres"
var learningSystemsData = LearningSystems.new()

func _ready():
	if DirAccess.dir_exists_absolute(location):
		if FileAccess.file_exists(location + learning_systems_file_name):
			learningSystemsData = ResourceLoader.load(location + learning_systems_file_name)
		else:
			save_learning_system_data()
	else:
		DirAccess.make_dir_absolute(location)
		
func save_learning_system_data():
	ResourceSaver.save(learningSystemsData, location + learning_systems_file_name)

func get_leitner_session_number():
	return learningSystemsData.leitner_session_number

func set_leitner_session_number(target_session_number):
	if target_session_number < 0: 
		return 
	if target_session_number > 9:
		learningSystemsData.leitner_session_number = 1 
	else:
		learningSystemsData.leitner_session_number += target_session_number
	save_learning_system_data()
	
func increment_leitner_session_number():
	# in the leitner algorithm there are only 9 boxes 10 boxes. Uncategoried (index 0) and 9 others 
	if learningSystemsData.leitner_session_number == 9:
		learningSystemsData.leitner_session_number = 1 
	else:
		learningSystemsData.leitner_session_number += 1
	save_learning_system_data()

func promote_leitner_word_to_next_box(word_id: String, next_box = null):
	var current_box = ""
	var current_box_index = -1 
	for box_name in learningSystemsData.leitner_box_names_order:
		var words = learningSystemsData.leitner_box_number_to_words[box_name]
		var word_index = words.find(word_id)
		if word_index == -1: 
			continue 
		else:
			current_box = box_name 
			current_box_index = word_index 
			break
	var next_box_name = learningSystemsData.get_next_box_name(current_box) if next_box == null else learningSystemsData.leitner_box_names_order[next_box]
		
	learningSystemsData.leitner_box_number_to_words[current_box].remove_at(current_box_index)
	learningSystemsData.leitner_box_number_to_words[next_box_name].append(word_id)
	save_learning_system_data()
	
func get_column_index_given_word_id(word_id):
	var word_box_name = ""
	var current_box_index = -1 
	for box_name in learningSystemsData.leitner_box_names_order:
		var word_ids = learningSystemsData.leitner_box_number_to_words[box_name]
		var word_index = word_ids.find(word_id)
		if word_index == -1: 
			continue 
		else:
			word_box_name = box_name 
			
			break
	return learningSystemsData.leitner_box_names_order.find(word_box_name)
	
func get_all_leitner_box_names():
	return learningSystemsData.leitner_box_names_order

func get_words_from_index(box_index):
	if box_index <= 9 and box_index >= 0:
		var box_name = learningSystemsData.leitner_box_names_order[box_index]
		return learningSystemsData.leitner_box_number_to_words[box_name]
	else:
		return false 
	
func given_box_names_get_slice_of_words(box_names, slice_size = null):
	var selection_of_words = []
	for box_name in box_names:
		var slice_of_words = learningSystemsData.leitner_box_number_to_words[box_name].slice(slice_size)
		selection_of_words += slice_of_words
	return selection_of_words
	
func save_word_to_uncategorized_box(word_id : String):
	learningSystemsData.leitner_box_number_to_words["uncategorized"].append(word_id)
	save_learning_system_data()
	
func save_words_to_uncategorized_box(word_ids: Array[String]):
	learningSystemsData.leitner_box_number_to_words["uncategorized"].concat(word_ids)
	save_learning_system_data()
	
func get_uncategorized_word_ids():
	return learningSystemsData.leitner_box_number_to_words["uncategorized"]
	
func remove_word_from_leitner_system(word_id):
	for box_name in learningSystemsData.leitner_box_number_to_words.keys():
		var words = learningSystemsData.leitner_box_number_to_words[box_name]
		var word_index = words.find(word_id)
		if word_index == -1: 
			continue 
		else:
			var before = learningSystemsData.leitner_box_number_to_words[box_name][word_index]
			
			learningSystemsData.leitner_box_number_to_words[box_name].remove_at(word_index)
			var after = learningSystemsData.leitner_box_number_to_words[box_name][word_index]
			save_learning_system_data()
			return true 
	return false 

func get_simple_queue_words():
	return learningSystemsData.simple_queue

func remove_word_from_simple_queue(word_id):
	var word_index = learningSystemsData.simple_queue.find(word_id) 
	if word_index >= 0:
		learningSystemsData.simple_queue.remove_at(word_index)
		save_learning_system_data()
		return true 
	else:
		return false 
		
func add_word_to_simple_queue(word_id):
	if learningSystemsData.simple_queue.size() <= learningSystemsData.simple_queue_max_length:
		learningSystemsData.simple_queue.append(word_id)
		save_learning_system_data()
		return true 
	else:
		return false 
