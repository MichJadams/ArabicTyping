extends HBoxContainer

func _ready():
	_draw_cards()
	
func _draw_cards():
	for word in LeitnerSystem.get_words_for_this_session():
		var card = LeitnerBoxItem.new(word, 0)
		card.custom_minimum_size.x = 300
		add_child(card)	

func _on_leitner_session_number_value_changed(value):
	var children = self.get_children()
	for c in children:
		self.remove_child(c)
		c.queue_free()
	_draw_cards()
