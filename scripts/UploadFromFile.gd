extends Button

@onready var file_dialog = $"../FileDialog"
@onready var panel = $"../Panel"

func _on_pressed():
	file_dialog.visible = true

func _on_close_btn_pressed():
	panel.visible = false
