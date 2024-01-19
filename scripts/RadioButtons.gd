extends GridContainer

@onready var use_leitner_system = $UseLeitnerSystem
@onready var use_simple_queue = $UseSimpleQueue

func _ready():
	var selected_learning_system = UserSettingsManager.get_learning_system()
	match selected_learning_system:
		LearningSystems.LearningSystemType.LEITNER:
			use_leitner_system.set_pressed_no_signal(true)
		LearningSystems.LearningSystemType.SIMPLEQUEUE:
			use_simple_queue.set_pressed_no_signal(true)
	
func _on_use_leitner_system_toggled(toggled_on):
	UserSettingsManager.update_learning_system(LearningSystems.LearningSystemType.LEITNER)

func _on_use_simple_queue_toggled(toggled_on):
	UserSettingsManager.update_learning_system(LearningSystems.LearningSystemType.SIMPLEQUEUE)
