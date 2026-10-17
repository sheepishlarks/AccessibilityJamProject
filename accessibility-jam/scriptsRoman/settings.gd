extends Control

@onready var MASTER_BUS_ID = AudioServer.get_bus_index("Master")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")

@export var id_value: int
@export var volume_value: int
@export var speed_value: float

# var text = get_tree().get_nodes_in_group("Text")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# text.add_theme_font_size_override("font_size", $SettingsContainer/SizeContainer/SizeSlider.value)
	AudioServer.set_bus_volume_db(MASTER_BUS_ID, linear_to_db($SettingsContainer/MasterContainer/MasterSlider.value) - 70)
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db($SettingsContainer/MusicContainer/MusicSlider.value) - 20)
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db($SettingsContainer/SFXContainer/SFXSlider.value) - 70)
	id_value = $SettingsContainer/VoiceContainer/IDSlider.value
	volume_value = $SettingsContainer/VoiceContainer/VoiceSlider.value
	speed_value = $SettingsContainer/VoiceContainer/VoiceSlider2.value

func _on_size_slider_value_changed(value: int) -> void:
	$SettingsContainer/SizeContainer/SizeLabel.add_theme_font_size_override("font_size", value)

func _on_master_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(MASTER_BUS_ID, linear_to_db(value) - 100)

func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value))

func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))

func _on_id_slider_value_changed(value: int) -> void:
	id_value = value

func _on_voice_slider_value_changed(value: int) -> void:
	volume_value = value

func _on_voice_slider_2_value_changed(value: float) -> void:
	speed_value = value
