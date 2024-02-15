extends Node

const SESSION_WORD_INDEX_OFFSET = 1
var words_for_this_session = []
var input_text = ""
var target_text = ""
var correct_map: Array
var session_word_index: int = 0
var selected_learning_system: LearningSystem
@onready var input_text_component = $InputText
@onready var target_text_component = $TargetText
@onready var typo_count = $TypoCount
@onready var progress_bar = $ProgressBar
@onready var session_number = $SessionNumber
@onready var http_request = $HTTPRequest

enum PracticeState { TYPING_TARGET_WORD, VIEWING_SOURCE_WORD }
var current_practice_state = PracticeState.TYPING_TARGET_WORD

func _init():
	set_learning_session()
	
func set_learning_session():
	match UserSettingsManager.get_learning_system():
		LearningSystems.LearningSystemType.LEITNER:
			selected_learning_system = LeitnerSystem.new()
		LearningSystems.LearningSystemType.SIMPLEQUEUE:
			selected_learning_system = SimpleQueueSystem.new()
	
func _ready():
	words_for_this_session = selected_learning_system.get_words_for_this_session()
	var target_word = words_for_this_session[session_word_index]
	target_text = target_word.arabic_word
	correct_map = Constants.initilize_map_array(target_text.length())
	update_visual()
	progress_bar.generate_completion_pips(words_for_this_session.size())

func get_audio():
	http_request.fetch_arabic_word(words_for_this_session[session_word_index])
	
func update_visual():
	target_text_component.display_text(target_text, correct_map)
	input_text_component.display_text(input_text, correct_map)
	
func _input(event):
	if event is InputEventKey and event.is_pressed():
		var char_input = OS.get_keycode_string(event.unicode)
		if char_input.length() != 1:
			process_other_key_press(event.key_label)
		else:
			process_input_char(char_input)
		if current_practice_state != PracticeState.VIEWING_SOURCE_WORD:
			update_correctness_map()
			update_score(input_text.length()-1)
			update_visual()
			
func process_other_key_press(key_label):
	if key_label == Key.KEY_SPACE:
		process_input_char(" ")
	if key_label == UserSettingsManager.get_play_audio_key():
		get_audio()
	if key_label == Key.KEY_BACKSPACE:
		input_text = input_text.substr(0, input_text.length() -1)
	if key_label == Key.KEY_ENTER and current_practice_state == PracticeState.VIEWING_SOURCE_WORD:
		get_next_word()
		
func process_input_char(input_char):
	if input_char.length() != 1:
			return 
	if input_text.length() < target_text.length(): 
		input_text = input_text + input_char
		
func update_correctness_map():
	var index = 0
	for char in target_text:
		if index >= correct_map.size() or index >= input_text.length():
			correct_map[index] = 0 
		elif char == input_text[index]:
			correct_map[index] = 1
		else:
			correct_map[index] = -1
		index = index + 1 
		
func update_score(recent_index_update):
	var target_word: VocabularyWord = words_for_this_session[session_word_index]

	if correct_map.all(func(number): return number == 1):
		selected_learning_system.promote_word(target_word.id)
		target_text_component.display_text(target_word.english_word, [])
		current_practice_state = PracticeState.VIEWING_SOURCE_WORD
		target_text = target_word.english_word
		correct_map = Constants.initilize_map_array(target_text.length())
	# Here is where I can update type count and stuff, but not right now.

func get_next_word():
	session_word_index += 1
	
	if session_word_index >= words_for_this_session.size(): 
		selected_learning_system.increment_session()
		get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
	else:
		progress_bar.update_progress(session_word_index - SESSION_WORD_INDEX_OFFSET)
		input_text = ""
		var target_word = words_for_this_session[session_word_index]
		target_text = target_word.arabic_word
		correct_map = Constants.initilize_map_array(target_word.arabic_word.length())
		current_practice_state = PracticeState.TYPING_TARGET_WORD
	
func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
