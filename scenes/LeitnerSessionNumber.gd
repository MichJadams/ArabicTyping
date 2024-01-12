extends SpinBox

func _ready():
	set_value_no_signal(MetaStatisticsManager.get_session_number())
	
func _on_value_changed(value):
	MetaStatisticsManager.set_session_number(value)
	LeitnerSystem.new()
