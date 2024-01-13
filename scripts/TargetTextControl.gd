extends RichTextLabel

@export var default_color: Color = Color.BLACK
@export var incorrect_color: Color = Color.RED
@export var correct_color: Color = Color.GREEN_YELLOW

func _ready():
	set_text_direction(Control.TEXT_DIRECTION_RTL)

func display_text(incoming_text, correct_map = []):
	clear()
	if correct_map.size() == 0:
		add_text(incoming_text)
	else:
		paint_letters_correctness(incoming_text, correct_map)
		
func paint_letters_correctness(incoming_text, correct_map):
	var index = 0
	for character in incoming_text: 
		if index >= correct_map.size():
			add_text(character)
			index += 1
			continue 
		 # could probably use some enums here .... 
		match correct_map[index]:
			0:
				push_color(Color.BLACK)
			-1:
				push_color(Color.RED)
			1:
				push_color(Color.GREEN_YELLOW)
		index += 1
		
		add_text(character)
		pop()
