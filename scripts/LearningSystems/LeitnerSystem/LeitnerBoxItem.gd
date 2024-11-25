extends Panel

class_name LeitnerBoxItem
var is_being_dragged = false 
var displayWord: DisplayWord
var word: VocabularyWord
var remove_word: Callable

func _init(incoming_word: DisplayWord, remove_word = null):
	self.displayWord = incoming_word
	self.word = VocabularyManager.get_word_by_id(incoming_word.word_id)
	self.theme = load("res://scripts/autoload/Settings.tres")
	self.remove_word = remove_word
	custom_minimum_size.x = 300
	custom_minimum_size.y = 400

	size_flags_horizontal = Control.SIZE_EXPAND_FILL
	mouse_filter = Control.MOUSE_FILTER_PASS
	add_backgrounk()
	add_label_container()
	
func add_backgrounk():
	var back = TextureRect.new()
	back.texture = preload("res://assets/card/arabestVocabCard_01_cut.png")
	back.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	back.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
	back.size = Vector2(300, 400)
	add_child(back)
	 
func _get_drag_data(_at_postion):
	set_drag_preview(get_drag_preview())
	return displayWord

func add_label_container():
	var container = add_container()
	add_delete_button(container)
	#add_label("Arabic:", container)
	add_label(word.arabic_word, container)
	
	#add_label("Translation:", container)
	add_label(word.english_word, container)
	#add_label("Display Index:", container)
	#add_label(str(displayWord.display_index), container)
	

func add_label(text: String, container: GridContainer):
	var label = Label.new()
	label.text = text
	label.add_theme_color_override("font_color",Color.BLACK)
	label.add_theme_font_size_override("font_size",50)
	label.mouse_filter = Control.MOUSE_FILTER_PASS
	label.size_flags_vertical = Control.SIZE_EXPAND_FILL
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	container.add_child(label)
	
func add_delete_button(container: GridContainer):
	var button = Button.new()
	button.text = "X"
	button.mouse_filter = Control.MOUSE_FILTER_PASS
	button.button_down.connect(func(): remove_word.call(word.id))
	button.size_flags_horizontal =Control.SIZE_SHRINK_END
	container.add_child(button)

func add_container():
	var margins = MarginContainer.new()
	margins.add_theme_constant_override("margin_top", 20)
	margins.add_theme_constant_override("margin_bottom", 20)
	margins.add_theme_constant_override("margin_right", 20)
	margins.add_theme_constant_override("margin_left", 20)
	margins.mouse_filter = Control.MOUSE_FILTER_PASS

	add_child(margins)
	
	var container = GridContainer.new()
	container.set_process_unhandled_input(false)
	container.mouse_filter = Control.MOUSE_FILTER_PASS
	container.custom_minimum_size = Vector2(250, 300)
	margins.add_child(container)
	
	container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	container.size_flags_vertical = Control.SIZE_EXPAND_FILL
	container.layout_mode = 1
	container.anchors_preset = PRESET_CENTER
	container.columns = 1
	
	return container

func get_drag_preview():
	var preview = ColorRect.new()
	preview.set_size(Vector2(100,100))
	preview.color = Color.BLUE
	return preview
