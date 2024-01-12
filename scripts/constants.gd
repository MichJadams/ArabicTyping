extends Node

class_name Constants 

const box_names_order = ['uncategorized', '0-2-5-9', '1-3-6-0', '2-4-7-1', '3-5-8-2','4-6-9-3', '5-7-0-4', '6-8-1-5', '7-9-2-6', '8-0-3-7', '9-1-4-8', 'retired_deck' ]
const str_box_names_order = ['uncategorized','0259', '1360', '2471', '3582','4693', '5704', '6815', '7926', '8037', '9148', 'retired_deck' ]

static func initilize_map_array(length):
	var a = []
	a.resize(length)
	a.fill(0)
	return a 

