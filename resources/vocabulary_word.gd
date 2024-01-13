extends Resource

class_name VocabularyWord

@export var arabic_word = ""
@export var english_word = ""
@export var presented_count = 0 
@export var last_date_presented = 0
@export var id = ""
@export var display_index = 0
@export var audio: PackedByteArray = []
	
func _init(arabicWord = "", englishWord = ""):
	arabic_word = arabicWord
	english_word = englishWord 
	id = generate_id(arabicWord, englishWord)
	
func generate_id(arabic_word, english_word):
	# Maybe return to this, if this no longer serves good uniquness purposes
	var combined_string = arabic_word + english_word
	return combined_string.md5_text() #md5 for speed baby!
	
func presented():
	presented_count += 1 
	last_date_presented = Time.get_date_dict_from_system()
