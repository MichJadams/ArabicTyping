extends FileDialog

@onready var file_dialog = $"."

func _ready():
	set_filters(PackedStringArray(["*.csv ; csv files"]))
	file_dialog.current_dir = "C:/Users/mjada/Desktop"

func _on_file_selected(path):
	var contents = FileAccess.get_file_as_string(path)
	var lines = contents.split("\n");
	var words_to_save = [] 
	for line in lines:
		var word = get_word_from_line(line)
		words_to_save.append(word)
	VocabularyManager.add_words(words_to_save)

func get_word_from_line(vocabulary_csv_line):
	var parts_from_line = vocabulary_csv_line.split(",")
	if(parts_from_line.size() >= 2):
		return VocabularyWord.new(parts_from_line[0], parts_from_line[1])
	pass
