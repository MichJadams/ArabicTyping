extends GridContainer

func _on_use_leitner_system_toggled(toggled_on):
	MetaStatisticsManager.update_learning_system(LearningSystems.LearningSystemType.LEITNER)

func _on_use_simple_queue_toggled(toggled_on):
	MetaStatisticsManager.update_learning_system(LearningSystems.LearningSystemType.LEITNER)
