extends Node

const SESSION_WORD_INDEX_OFFSET = 1
var input_text = ""
var target_word: VocabularyWord
var target_text: String
var correct_map: Array
var session_word_index: int
var selected_learning_system: LearningSystem
@onready var input_text_component = $InputText
@onready var target_text_component = $TargetText
@onready var typo_count = $TypoCount
@onready var progress_bar = $ProgressBar
@onready var session_number = $SessionNumber
@onready var http_request = $HTTPRequest

enum PracticeState {typing_arabic, viewing_english}
var current_practice_state = PracticeState.typing_arabic

func _init():
	set_learning_session()
	
func set_learning_session():
	var user_saved_learning_system = MetaStatisticsManager.get_learning_system()
	
	if user_saved_learning_system == LearningSystems.LearningSystemType.LEITNER:
		selected_learning_system = LeitnerSystem.new()
	if user_saved_learning_system == LearningSystems.LearningSystemType.SIMPLEQUEUE:
		selected_learning_system = SimpleQueueSystem.new()
	
func _ready():
	session_word_index = 0
	target_word = selected_learning_system.get_next_word(session_word_index)
	target_text = target_word.arabic_word
	
	correct_map = Constants.initilize_map_array(target_text.length())
	target_text_component.display_text(target_text, correct_map)
	get_audio(target_word)
	progress_bar.generate_completion_pips(selected_learning_system.words_for_this_session.size())

func get_audio(target_word):
	http_request.fetch_arabic_word(target_word)
	
func compare_text():
	var index = 0
	if current_practice_state == PracticeState.viewing_english:
		return 
	for char in target_text:
		if index >= correct_map.size() or index >= input_text.length():
			correct_map[index] = 0 
		elif char == input_text[index]:
			correct_map[index] = 1
		else:
			correct_map[index] = -1
		index = index + 1 
	update_score(input_text.length()-1)
	
func update_score(recent_index_update):
	if current_practice_state == PracticeState.viewing_english:
		pass 
	elif correct_map.all(func(number): return number == 1):
		target_text = target_word.english_word
		correct_map = Constants.initilize_map_array(target_text.length())
		current_practice_state = PracticeState.viewing_english
	elif correct_map[recent_index_update] == -1:
		VocabularyManager.update_word_typo_count()
	var score = VocabularyManager.get_typo_count()
	typo_count.text = str(score)
	session_number.text = str(MetaStatisticsManager.get_session_number())
	
func _input(event):
	if event is InputEventKey and event.is_pressed():
		var input_char = OS.get_keycode_string(event.unicode)
		if event.key_label == Key.KEY_BACKSPACE:
			input_text = input_text.substr(0, input_text.length() -1)
		if input_char.length() == 1 and input_text.length() < target_text.length(): 
			input_text = input_text + input_char
		if event.key_label == Key.KEY_ENTER and current_practice_state == PracticeState.viewing_english:
			session_word_index += 1
			get_next_word()
		else:
			compare_text()
		update_components()
		
func update_components():
	target_text_component.display_text(target_text, correct_map)
	input_text_component.display_text(input_text, correct_map)
	
func get_next_word():
	if selected_learning_system.is_session_over(session_word_index): 
		selected_learning_system.increment_session()
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	else:
		progress_bar.update_progress(session_word_index - SESSION_WORD_INDEX_OFFSET)
		input_text = ""
		target_word = selected_learning_system.get_next_word(session_word_index)
		target_text = target_word.arabic_word 
		correct_map = Constants.initilize_map_array(target_text.length())
		current_practice_state = PracticeState.typing_arabic
	http_request.fetch_arabic_word(target_word)
	
func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
