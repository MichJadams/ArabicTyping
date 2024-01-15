extends Label

@onready var control = $".."

func _ready():
	recalculate_display()
	
func recalculate_display():
	var learning_session_number = LearningSystemsManager.get_leitner_session_number()
	var todays_boxes_and_selected_card_count = control.leitnerSystem.given_session_get_boxes(learning_session_number)
	var column_numbers = []
	for box in todays_boxes_and_selected_card_count:
		var column_number = Constants.box_names_order.find(box)
		if column_number >= 0: 
			column_numbers.append(column_number)
	text = "Session Number: %s \t Column Numbers: %s" % [learning_session_number, column_numbers]

func _on_leitner_session_number_value_changed(value):
	recalculate_display()
