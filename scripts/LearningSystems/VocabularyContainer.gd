extends VBoxContainer

func _ready():
	_draw_cards()
	
func _draw_cards():
	var children = self.get_children()
	for c in children:
		self.remove_child(c)
		c.queue_free()
		
	var words = VocabularyManager.get_all_words()
	for display_index in words.size():
		var display_word = DisplayWord.new(words[display_index].id, display_index)
		var card = LeitnerBoxItem.new(display_word, _draw_cards)
		card.custom_minimum_size.x = 300
		add_child(card)
