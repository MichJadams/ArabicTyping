extends ColorRect

var node_width
var padding = 25
var pip_childern = []
var circle_filled = load("res://assets/practice/circle_filled.png")

func _ready():
	node_width = get_size().x
	
func generate_completion_pips(number_of_pips):
	var empty_circle_texture = load("res://assets//practice/circle_outline.png")
	var progress_unit_width = (node_width/number_of_pips) + padding 
	for pip_index in number_of_pips:
		var progress_pip = Sprite2D.new()
		progress_pip.texture = empty_circle_texture
		progress_pip.scale = Vector2(0.05, 0.05)
		progress_pip.position = Vector2(pip_index * progress_unit_width, 0)
		pip_childern.append((progress_pip))
		add_child(progress_pip)	

func reset_progress():
	for n in get_children():
		remove_child(n)
		n.queue_free()
		
func update_progress(pip_index):
	var current_pip = pip_childern[pip_index]
	current_pip.texture = circle_filled
