extends RichTextLabel

func _ready():
	set_text_direction(Control.TEXT_DIRECTION_RTL)
	
func display_text(text, correct_map):
	var index = 0
	clear()
	for char in text: 
		var status = 0;
		if index < correct_map.size():
			status = correct_map[index]
			index += 1
		else:
			break
		if status == 0:
			push_color(Color.WHITE_SMOKE)
		if status == -1:
			push_color(Color.RED)
		if status == 1:
			push_color(Color.GREEN_YELLOW)
		add_text(char)
		pop()
