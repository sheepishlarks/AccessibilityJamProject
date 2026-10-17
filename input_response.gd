extends VBoxContainer

var voices = DisplayServer.tts_get_voices_for_language("en")
var voice_id = voices[1]

func set_text(input: String, response: String, volume: int, speed: float): 
	$InputHistory.text = " > " + input
	$Response.text = response 
	var joint: String = input + ". " + response
	DisplayServer.tts_speak(joint, voice_id, volume, 1.0, speed)

func set_response_text(response: String): 
	$Response.text = response
