extends Button

@onready var file_dialog = $"../FileDialog"

func _on_pressed():
	file_dialog.visible = true
