extends Node

var learning_systems_location = "user://save/"
var learning_systems_file_name = "learningSystems.tres"
var learningSystems = LearningSystems.new()

func _ready():
	if DirAccess.dir_exists_absolute(learning_systems_location):
		if FileAccess.file_exists(learning_systems_location + learning_systems_file_name):
			learningSystems = ResourceLoader.load(learning_systems_location + learning_systems_file_name)
		else:
			save_learning_system_data()
	else:
		DirAccess.make_dir_absolute(learning_systems_location)
		
func save_learning_system_data():
	ResourceSaver.save(learningSystems, learning_systems_location + learning_systems_file_name)

func get_leitner_session_number():
	return learningSystems.leitner_session_number

func increment_leitner_session_number():
	# in the leitner algorithm there are only 9 boxes 10 boxes. Uncategoried (index 0) and 9 others 
	if learningSystems.leitner_session_number == 9:
		learningSystems.leitner_session_number = 1 
	else:
		learningSystems.leitner_session_number += 1
	save_learning_system_data()

func get_all_leitner_box_names():
	return learningSystems.leitner_box_names_order

func given_box_names_get_slice_of_words(box_names: Array[String], slice_size):
	var selection_of_words = []
	for box_name in box_names:
		var slice_of_words = learningSystems.leitner_box_names_order[box_name].slice(slice_size)
		selection_of_words.append(slice_of_words)
	return selection_of_words
	
func save_word_to_uncategorized_box(word_id : String):
	learningSystems.leitner_box_names_order["uncategorized"].append(word_id)
	save_learning_system_data()
	
func get_uncategorized_words():
	return learningSystems.leitner_box_names_order["uncategorized"]
	
