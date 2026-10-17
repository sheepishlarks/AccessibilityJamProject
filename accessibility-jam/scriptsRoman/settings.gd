extends Control

@onready var MASTER_BUS_ID = AudioServer.get_bus_index("Master")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")

@export var id_value: int = 0
@export var volume_value: int = 50
@export var speed_value: float = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioServer.set_bus_volume_db(MASTER_BUS_ID, linear_to_db($SettingsContainer/MasterContainer/MasterSlider.value) - 70)
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db($SettingsContainer/MusicContainer/MusicSlider.value) - 20)
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db($SettingsContainer/SFXContainer/SFXSlider.value) - 70)

func _on_size_slider_value_changed(value: int) -> void:
	var font = get_tree().root.get_theme_font("string_name", "")
	font.set_font_size("string_name", value)
	# add_theme_constant_override(, value)

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
