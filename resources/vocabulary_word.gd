extends Resource

class_name VocabularyWord

@export var arabic_word: String = ""
@export var english_word: String = ""
@export var presented_count: int = 0 
@export var last_date_presented = 0
@export var id: String = ""
@export var audio: PackedByteArray = []
	
func _init(arabicWord = "", englishWord = ""):
	arabic_word = arabicWord
	english_word = englishWord 
	id = generate_id()
	
func generate_id() -> String:
	# Maybe return to this, if this no longer serves good uniquness purposes
	var combined_string = arabic_word + english_word
	return combined_string.md5_text() #md5 for speed baby!
	
func presented():
	presented_count += 1 
	last_date_presented = Time.get_date_dict_from_system()
