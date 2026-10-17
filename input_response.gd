extends VBoxContainer

var voices = DisplayServer.tts_get_voices_for_language("en")
var voice_id = voices[1]
var volume: int = 60; var speed: float = 1;

func set_text(input: String, response: String): 
	$InputHistory.text = " > " + input
	$Response.text = response 
	DisplayServer.tts_speak(input, voice_id, volume, 1.0, speed)

func set_response_text(response: String): 
	$Response.text = response
	DisplayServer.tts_speak(response, voice_id, volume, 1.0, speed)
	# var joint: String = input + ". " + response
	# DisplayServer.tts_speak(joint, voice_id, volume, 1.0, speed)
