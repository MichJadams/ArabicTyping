extends FileDialog
@onready var file_dialog: FileDialog = $"."


func _ready():
	set_filters(PackedStringArray(["*.csv ; csv files"]))
	file_dialog.current_dir = "C:/Users/mjada/Desktop"
