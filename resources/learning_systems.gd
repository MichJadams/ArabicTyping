extends Resource
class_name LearningSystems
enum LearningSystemType {
	LEITNER,
	SIMPLEQUEUE
}
@export var leitner_session_number = 0 
@export var leitner_box_names_order = ['0-2-5-9', '1-3-6-0', '2-4-7-1', '3-5-8-2','4-6-9-3', '5-7-0-4', '6-8-1-5', '7-9-2-6', '8-0-3-7', '9-1-4-8' ]
@export var leitner_box_number_to_words = {
	'uncategorized': [],
	'0-2-5-9':[], 
	'1-3-6-0':[], 
	'2-4-7-1':[], 
	'3-5-8-2':[],
	'4-6-9-3':[], 
	'5-7-0-4':[], 
	'6-8-1-5':[], 
	'7-9-2-6':[], 
	'8-0-3-7':[], 
	'9-1-4-8':[]
}

func get_next_box_name(current_box_name):
	var current_box_index = leitner_box_names_order.find(current_box_name)
	if current_box_index == -1:
		return "uncategorized"
	if current_box_index == 9:
		return "0-2-5-9"
	current_box_index += 1
	return leitner_box_names_order[current_box_index]
