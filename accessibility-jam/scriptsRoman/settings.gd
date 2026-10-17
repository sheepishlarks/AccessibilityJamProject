extends Control

@onready var MASTER_BUS_ID = AudioServer.get_bus_index("Master")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
@onready var VOICE_BUS_ID = AudioServer.get_bus_index("Voice")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioServer.set_bus_volume_db(MASTER_BUS_ID, linear_to_db($SettingsContainer/MasterContainer/MasterSlider.value) - 70)
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db($SettingsContainer/MusicContainer/MusicSlider.value) - 20)
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db($SettingsContainer/SFXContainer/SFXSlider.value) - 70)
	AudioServer.set_bus_volume_db(VOICE_BUS_ID, linear_to_db($SettingsContainer/SFXContainer/SFXSlider.value) - 70)

# func _on_size_slider_value_changed(value: float) -> void:
#	

func _on_master_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(MASTER_BUS_ID, linear_to_db(value) - 100)

func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value))

func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))

func _on_back_button_pressed() -> void:
	hide()
