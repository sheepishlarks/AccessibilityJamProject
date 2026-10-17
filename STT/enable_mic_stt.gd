extends CheckBox

const DEFAULT_INPUT_DEVICE := "Default"

@export var mic_player: AudioStreamPlayer 
@export var audio_to_text: CaptureStreamToText 
#@onready var input_device_label: Label = get_node_or_null("../InputDeviceLabel") as Label
#@onready var input_device: OptionButton = get_node_or_null("../InputDevice") as OptionButton

#var _device_switch_generation := 0

signal stt_on_off(on_off:bool)

func _ready():
	pass
#	_populate_input_devices()
	#if input_device != null:
	#	input_device.item_selected.connect(_on_input_device_item_selected)


func start_selected_source() -> void:
	_on_toggled(button_pressed)


func _on_toggled(toggled_on: bool):
	if toggled_on:
		_restart_microphone_stream()
		mic_player.play()
		emit_signal("stt_on_off", true)
	else:
		mic_player.stop()
		emit_signal("stt_on_off", true)

func _restart_microphone_stream() -> void:
	mic_player.stream = AudioStreamMicrophone.new()
	mic_player.bus = "Record"
