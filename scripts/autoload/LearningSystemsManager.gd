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

func increment_leitner_session_number():
	# in the leitner algorithm there are only 9 boxes 10 boxes. Uncategoried (index 0) and 9 others 
	if learningSystemsData.leitner_session_number == 9:
		learningSystemsData.leitner_session_number = 1 
	else:
		learningSystemsData.leitner_session_number += 1
	save_learning_system_data()

func promote_leitner_word_to_next_box(word_id):
	var current_box = ""
	var current_box_index = -1 
	for box_name in learningSystemsData.leitner_box_number_to_words.keys():
		var words = learningSystemsData.leitner_box_number_to_words[box_name]
		var word_index = words.find(word_id)
		if word_index != -1: 
			continue 
		else:
			current_box = box_name 
			current_box_index = word_index 
			break
	var next_box_name = learningSystemsData.get_next_box_name(current_box)
	learningSystemsData.leitner_box_number_to_words[current_box].remove_at(current_box_index)
	learningSystemsData.leitner_box_number_to_words[next_box_name].append(word_id)
	save_learning_system_data()

func get_all_leitner_box_names():
	return learningSystemsData.leitner_box_names_order

func given_box_names_get_slice_of_words(box_names, slice_size):
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
	
func get_words_for_box_index(box_index):
	pass
