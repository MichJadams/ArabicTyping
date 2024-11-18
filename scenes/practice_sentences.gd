extends Control

@onready var api_input: TextEdit = $GridContainer/api_input
@onready var get_ai_answer: HTTPRequest = $get_ai_answer
@onready var arabic_input: TextEditTab = $GridContainer/arabic_input
@onready var english_input: TextEditTab = $GridContainer/english_input
@onready var grading_response: RichTextLabel = $"GridContainer/Grading Response"
@onready var file_dialog: FileDialog = $file_to_save_to/FileDialog
@onready var corrected_arabic: TextEditTab = $GridContainer/corrected_arabic

const sentence_location = "user://save/"
const sentences_file_name = "sentences.tres"
const uri = "https://api.openai.com/v1/chat/completions"
var api_key = ""
var sentenceSaver = SentenceSaver.new()

func _ready() -> void:
	var sentenceSaver = ResourceLoader.load(sentence_location + sentences_file_name)
	
func _on_grade_pressed() -> void:
	api_key = api_input.text
	var arabic = arabic_input.text # "كم تلميز بصف ؟ # 
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
	var today = Time.get_date_string_from_system()
	var thing_to_save = {
		"arabic": arabic_input.text,
		"english_input": english_input.text,
		"corrected_arabic": corrected_arabic.text
	}
	if today in sentenceSaver.sentences:
		sentenceSaver.sentences[today].append(thing_to_save)
	else: 
		sentenceSaver.sentences[today] = [thing_to_save]
	ResourceSaver.save(sentenceSaver, sentence_location + sentences_file_name)
	arabic_input.text = ""
	english_input.text = ""
	corrected_arabic.text = ""
	grading_response.text = "Previous sentence saved!"
	
