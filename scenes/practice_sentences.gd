extends Control

@onready var api_input: TextEdit = $GridContainer/api_input
@onready var get_ai_answer: HTTPRequest = $get_ai_answer
@onready var arabic_input: TextEditTab = $GridContainer/arabic_input
@onready var english_input: TextEditTab = $GridContainer/english_input
@onready var grading_response: RichTextLabel = $"GridContainer/Grading Response"
@onready var file_dialog: FileDialog = $file_to_save_to/FileDialog

const uri = "https://api.openai.com/v1/chat/completions"
var api_key = ""

func _on_grade_pressed() -> void:
	api_key = api_input.text
	var arabic = arabic_input.text # "كم تلميز بصف ؟ " # 
	var english = english_input.text # "How many students do you have?"
	var body = JSON.new().stringify({
	  "model": "gpt-3.5-turbo-0125",  
	  "messages": [
		{
		  "role": "user",
		  "content": "I have a sentence I would like to try writing in Levantine Arabic. Here is the sentence in english "  + english + " and here is my attempt in arabic " + arabic + ". Can you correct the arabic for me and give a brief expanation of each part of the sentence?"
		}
	  ],
	  "max_tokens": 1000
	})

	var error = get_ai_answer.request(uri, ["Authorization: Bearer " + api_key, "Content-Type: application/json"], HTTPClient.METHOD_POST, body)
	if error != OK:
		push_error("An error occurred in the HTTP request.")

func _on_get_ai_answer_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()

	if(response.choices[0].message.content):
		grading_response.set_text(response.choices[0].message.content)
	else: 
		grading_response.text = "There was an issue " + String(response)

func _on_save_pressed() -> void:
		
	pass # Replace with function body.

func _on_file_to_save_to_pressed() -> void:
	file_dialog.show()
	pass # Replace with function body.
