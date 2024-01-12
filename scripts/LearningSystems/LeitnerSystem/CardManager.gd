extends GridContainer

@export var box_index: int
var cards = []

func _ready():
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	
func _on_leitner_box_add_words(signaling_box_index, words):
	if box_index == signaling_box_index:
		for word_index in words.size():
			var word = words[word_index]
			word.display_index = word_index
			self.cards.append(word)
		_draw_cards()
			
func _draw_cards():
	var children = self.get_children()
	for c in children:
		self.remove_child(c)
		c.queue_free()
		
	for card_index in self.cards.size():
		self.cards[card_index].display_index = card_index
		add_child(LeitnerBoxItem.new(self.cards[card_index], card_index))
	
func _on_control_add_word(signaling_box_index, word):
	if box_index == signaling_box_index:
		word.display_index = self.cards.size() 
		self.cards.append(word)
		_draw_cards()

func _on_control_remove_word(signaling_box_index, word):
	if box_index == signaling_box_index:
		self.cards.remove_at(word.display_index)
		_draw_cards()
