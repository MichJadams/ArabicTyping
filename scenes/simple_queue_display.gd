extends VBoxContainer

func _ready():
	_draw_cards()
	
func remove_word(word_id):
	if LearningSystemsManager.remove_word_from_simple_queue(word_id):
		_draw_cards()
		
func _draw_cards():
	var children = self.get_children()
	for c in children:
		self.remove_child(c)
		c.queue_free()
		
	var words = SimpleQueueSystem.get_words_for_this_session()
	for display_index in words.size():
		var display_word = DisplayWord.new(words[display_index].id, display_index)
		var card = LeitnerBoxItem.new(display_word, self.remove_word)
		#card.custom_minimum_size.x = 500
		add_child(card)
