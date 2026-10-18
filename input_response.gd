extends VBoxContainer

var voices = DisplayServer.tts_get_voices_for_language("en")
var voice_id = voices[Globals.tts_voice_id]

func set_text(input: String, response: String):
	 
	$InputHistory.text = " > " + input
	$Response.text = response 
	var joint: String = input + ". " + response
	DisplayServer.tts_speak(joint, voice_id, Globals.tts_volume_value, 1.0, Globals.tts_speed_value)

func set_response_text(response: String): 
	$Response.text = response
