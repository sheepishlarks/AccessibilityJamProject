extends LineEdit

##from input script
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grab_focus()

func focus() -> void: 
	grab_focus()

func _on_text_submitted(new_text: String) -> void:
	clear()

###Speach to Text###
var stt_on: bool
var completed_text := ""
var partial_text := ""
#var status_text := ""

func update_text() -> void:
	text =  completed_text + partial_text

func _process(_delta: float) -> void:
	if stt_on == true:
		update_text()

func set_stt_on_off(on_off: bool):
	stt_on = on_off
	if on_off == false:
		text = completed_text + partial_text
		clear_cashed_stt()
		completed_text = text
		selecting_enabled = true
	else:
		completed_text = text
		

## is_complete: true when a sentence/window boundary is committed, false when still in progress.
func _on_capture_stream_to_text_transcribed_msg(is_complete: bool, new_text: String) -> void:
	_on_capture_stream_to_text_transcribed_msg_confidence(is_complete, new_text, 1.0)


func _on_capture_stream_to_text_transcribed_msg_confidence(is_complete: bool, new_text: String, confidence: float) -> void:
	if is_complete:
		completed_text += new_text + " "
		partial_text = ""
	else:
		if new_text != "":
			partial_text = new_text


func _on_capture_stream_to_text_transcribed_msg_tokens(is_complete: bool, new_text: String, tokens: Array) -> void:
	if is_complete:
		completed_text += new_text + " "
		partial_text = ""
	else:
		if new_text != "":
			partial_text = new_text

func clear_cashed_stt():
	completed_text = ""
	partial_text = ""
	#status_text = ""
