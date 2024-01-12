extends Node

var vocabulary_location = "user://save/"
var vocabulary_file_name = "vocabulary.tres"
var vocab = SavedVocabulary.new()
var vocabulary_map = {}

func _ready():
	if DirAccess.dir_exists_absolute(vocabulary_location):
		if FileAccess.file_exists(vocabulary_location + vocabulary_file_name):
			load_vocabulary()
		else:
			save_vocabulary()
	else:
		DirAccess.make_dir_absolute(vocabulary_location)
		
func load_vocabulary():
	vocab = ResourceLoader.load(vocabulary_location + vocabulary_file_name)
	create_vocab_map()
	
func create_vocab_map():
	for word in vocab.words:
		if word != null and word.arabic_word != null:
			var word_key = word.arabic_word.hash()
			if word_key not in vocabulary_map:
				vocabulary_map[word_key] = word

func get_all_words():
	return vocab.words_by_id.values()
	
func get_word_by_id(word_id : String):
	return vocab.words_by_id.get(word_id)
	
func save_vocabulary():
	var new_array_of_words = []
	for value in vocabulary_map.values():
		new_array_of_words.append(value)
	vocab.words = new_array_of_words
	ResourceSaver.save(vocab, vocabulary_location + vocabulary_file_name)
	
func add_words(word_list):
	for word: VocabularyWord in word_list:
		var added = vocab.add_word(word)
		if added:
			LearningSystemsManager.save_word_to_uncategorized_box(word.id)
	save_vocabulary()
	
func remove_word(word_to_remove: VocabularyWord):
	var erased = vocabulary_map.erase(word_to_remove.arabic_word.hash())
	if erased:
		save_vocabulary()
		#load_vocabulary()
	else:
		print("this is the hash",word_to_remove.arabic_word.hash())
		pass

func add_pronunciation(arabic_word: String, audio_array: PackedByteArray):
	var word = vocabulary_map[arabic_word.hash()]
	word.audio = audio_array
	save_vocabulary()
	#load_vocabulary()
