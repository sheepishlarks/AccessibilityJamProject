extends VBoxContainer

@onready var mic_player: AudioStreamPlayer = $MicPlayer
@onready var audio_to_text: CaptureStreamToText = $CaptureStreamToText
@onready var transcribe_label: RichTextLabel = $Panel/Label
@onready var mic_toggle: CheckBox = $HBoxContainer/MicToggle

func _ready():
	mic_player.bus = "Record"
	audio_to_text.transcribed_msg_tokens.connect(transcribe_label._on_capture_stream_to_text_transcribed_msg_tokens)
	audio_to_text.emit_current_status()
	_start_initial_source.call_deferred()


func _start_initial_source() -> void:
	await get_tree().create_timer(0.5).timeout
	if is_instance_valid(mic_toggle) and mic_toggle.has_method("start_selected_source"):
		mic_toggle.call("start_selected_source")


func _exit_tree() -> void:
	if is_instance_valid(mic_player):
		mic_player.stop()
		mic_player.stream = null
