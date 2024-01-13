extends Node

var metaData_location = "user://save/"
var metaData_file_name = "metaData.tres"
var userSettings = UserSettings.new()

func _ready():
	if DirAccess.dir_exists_absolute(metaData_location):
		if FileAccess.file_exists(metaData_location + metaData_file_name):
			userSettings = ResourceLoader.load(metaData_location + metaData_file_name)
		else:
			save_statistics()
	else:
		DirAccess.make_dir_absolute(metaData_location)
		
func get_leitner_boxes():
	return userSettings.boxes
	


func get_session_number():
	return userSettings.sessionNumber

func save_statistics():
	ResourceSaver.save(userSettings, metaData_location + metaData_file_name)
	pass

func update_learning_system(new_learning_system: LearningSystems.LearningSystemType):
	userSettings.selected_learning_system = new_learning_system
	save_statistics()
	
func get_learning_system():
	return userSettings.selected_learning_system
