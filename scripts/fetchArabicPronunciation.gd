extends HTTPRequest

const url = "https://voice.reverso.net"
const params = "/RestPronunciation.svc/v1/output=json/GetVoiceStream/voiceName=Mehdi22k?voiceSpeed=100&inputText="
const headers = [
		"accept: */*", 
		"user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36 Edg/118.0.2088.69",
		"range: bytes=0-",
		"origin: https://context.reverso.net",
		"accept-language: en-US,en;q=0.9",
		"accept-encoding: identity" 
	]
@onready var audio_stream_player = $"../AudioStreamPlayer"
var arabic_word: String 

func _ready():
	self.request_completed.connect(callback)
	
func fetch_arabic_word(word: VocabularyWord):
	if word.audio.is_empty():
		var encoded_word = Marshalls.utf8_to_base64(word.arabic_word) 
		var final_url = url + params + encoded_word
		arabic_word = word.arabic_word
		request(final_url, headers)
	else:
		play_audio(word.audio)

func callback(_result, response_code, _headers, body: PackedByteArray):
	if response_code == 206:
		play_audio(body)
		VocabularyManager.add_pronunciation(arabic_word, body)
		
func play_audio(sound: PackedByteArray):
	var stream = AudioStreamMP3.new()
	stream.set_data(sound)
	audio_stream_player.set_stream(stream)
	audio_stream_player.play()
