extends SpinBox

func _ready():
	set_value_no_signal(UserSettingsManager.get_session_number())
	
func _on_value_changed(value):
	UserSettingsManager.set_session_number(value)
	LeitnerSystem.new()
