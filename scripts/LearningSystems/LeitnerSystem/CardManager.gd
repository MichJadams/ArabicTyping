extends GridContainer

@export var box_index: int
var cards: Array[DisplayWord] = []

func _ready():
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	
func _on_leitner_box_add_words(signaling_box_index, word_ids):
	if box_index == signaling_box_index:
		for word_index in word_ids.size():
			var display_word = DisplayWord.new(word_ids[word_index], word_index)
			self.cards.append(display_word)
		_draw_cards()
			
func _draw_cards():
	for c in self.get_children():
		self.remove_child(c)
		c.queue_free()
		
	for display_word in self.cards:
		add_child(LeitnerBoxItem.new(display_word))
	
func _on_control_add_word(signaling_box_index, display_word: DisplayWord):
	if box_index == signaling_box_index:
		self.cards.append(display_word)
		display_word.display_index = self.cards.find(display_word)
		_draw_cards()

func _on_control_remove_word(signaling_box_index, display_word):
	if box_index == signaling_box_index:
		self.cards.remove_at(display_word.display_index)
		_draw_cards()
