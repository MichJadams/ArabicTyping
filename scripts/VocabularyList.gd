extends ItemList

@onready var file_dialog = $"../FileDialog"

var vocabulary_location = "user://save/"
var vocabulary_file_name = "vocabulary.tres"
var vocab = SavedVocabulary.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	file_dialog.current_dir = "C:/Users/mjada/Desktop"
	if DirAccess.dir_exists_absolute(vocabulary_location):
		if FileAccess.file_exists(vocabulary_location + vocabulary_file_name):
			vocab = ResourceLoader.load(vocabulary_location + vocabulary_file_name)
			if(vocab is SavedVocabulary and vocab != null):
				add_vocab_words()

func add_vocab_words():
	for word in vocab.words:
		if(word != null):
			add_item(word.english_word)
