extends TextEdit

class_name  TextEditTab

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("ui_focus_next") and has_focus()):
		get_node(focus_next).grab_focus()
		get_viewport().set_input_as_handled()
	if(event.is_action_pressed("ui_focus_prev") and has_focus()):
		get_node(focus_previous).grab_focus()
		get_viewport().set_input_as_handled()
		
