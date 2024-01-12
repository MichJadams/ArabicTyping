extends Panel

class_name LeitnerBoxItem
var is_being_dragged = false 
var card_index: int
var word: VocabularyWord

func _init(incoming_word: VocabularyWord, index):
	self.card_index = index
	self.word = incoming_word
	self.theme = load("res://scripts/autoload/sandy.tres")
	
	custom_minimum_size.y = 275
	size_flags_horizontal = Control.SIZE_EXPAND_FILL
	mouse_filter = Control.MOUSE_FILTER_PASS
	add_label_container()
	
func _get_drag_data(_at_postion):
	set_drag_preview(get_drag_preview())
	return word

func add_label_container():
	var container = add_container()
	add_label("Arabic:", container)
	add_label(word.arabic_word, container)
	
	add_label("Translation:", container)
	add_label(word.english_word, container)
	
	add_label("Typos:", container)
	add_label(str(word.total_typos), container)
	
	add_delete_button(container)

	add_label("Leitner Index:", container)
	add_label(str(word.leitnerIndex), container)

func add_label(text: String, container: GridContainer):
	var label = Label.new()
	label.text = text
	label.add_theme_color_override("font_color",Color.BLACK)
	label.add_theme_font_size_override("font_size",20)
	label.mouse_filter = Control.MOUSE_FILTER_PASS

	container.add_child(label)
	
func add_delete_button(container: GridContainer):
	var button = Button.new()
	button.text = "X"
	button.mouse_filter = Control.MOUSE_FILTER_PASS
	button.button_down.connect(remove_word)
	container.add_child(button)
	
func remove_word():
	VocabularyManager.remove_word(word)
	
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
		
	margins.add_child(container)
	
	container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	container.size_flags_vertical = Control.SIZE_EXPAND_FILL
	container.layout_mode = 1
	container.anchors_preset = PRESET_CENTER
	container.columns = 2
	
	return container

func get_drag_preview():
	var preview = ColorRect.new()
	preview.set_size(Vector2(100,100))
	preview.color = Color.BLUE
	return preview
