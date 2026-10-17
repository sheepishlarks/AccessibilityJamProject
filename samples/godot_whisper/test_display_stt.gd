extends RichTextLabel


func update_text() -> void:
	text = status_text + completed_text + partial_text

func _process(_delta: float) -> void:
	update_text()

var completed_text := ""
var partial_text := ""
var status_text := ""

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
