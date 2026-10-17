extends VBoxContainer

var voices = DisplayServer.tts_get_voices_for_language("en")
var voice_id

func set_text(input: String, response: String, id: int, volume: int, speed: float):
	match id:
		0:
			voice_id = voices[0]
		1:
			voice_id = voices[1]
		2:
			voice_id = voices[2]
	 
	$InputHistory.text = " > " + input
	$Response.text = response 
	var joint: String = input + ". " + response
	DisplayServer.tts_speak(joint, voice_id, volume, 1.0, speed)

func set_response_text(response: String): 
	$Response.text = response
