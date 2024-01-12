extends RichTextLabel

func _ready():
	set_text_direction(Control.TEXT_DIRECTION_RTL)

func display_text(incoming_text, correct_map):
	var index = 0
	clear()
	for character in incoming_text: 
		var status = 0;
		if index < correct_map.size():
			status = correct_map[index]
			index += 1
		else:
			break
		if status == 0:
			push_color(Color.BLACK)
		if status == -1:
			push_color(Color.RED)
		if status == 1:
			push_color(Color.GREEN_YELLOW)
		add_text(character)
		pop()
