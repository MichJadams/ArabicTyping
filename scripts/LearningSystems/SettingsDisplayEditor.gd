extends ScrollContainer
@onready var v_box_container = $VBoxContainer

func _on_leitner_box_word_dropped(target_column_number, display_word:DisplayWord):
	print("here???")


func _can_drop_data(_pos, data):
	if data is DisplayWord:
		return true
	return false
	
func _drop_data(_pos, data):
	if data is DisplayWord:
		LearningSystemsManager.add_word_to_simple_queue(data.word_id)
		v_box_container._draw_cards()
