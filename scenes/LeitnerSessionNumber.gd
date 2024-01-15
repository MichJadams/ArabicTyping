extends SpinBox

func _ready():
	set_value_no_signal(LearningSystemsManager.get_leitner_session_number())
	
func _on_value_changed(value):
	LearningSystemsManager.set_leitner_session_number(value)
