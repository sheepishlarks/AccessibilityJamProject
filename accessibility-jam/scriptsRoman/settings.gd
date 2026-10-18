extends Control
class_name Settings

@onready var MASTER_BUS_ID = AudioServer.get_bus_index("Master")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")

@onready var pause_menu = $"."
var paused = false

@onready var id_value: int

var voices = DisplayServer.tts_get_voices_for_language("en")
var voice_id

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pause_menu.hide()
	get_tree().set_group("Text", "font_size", $SettingsContainer/SizeContainer/SizeSlider.value)
	
	$SettingsContainer/MasterContainer/MasterSlider.value = AudioServer.get_bus_volume_db(MASTER_BUS_ID)
	$SettingsContainer/MusicContainer/MusicSlider.value = AudioServer.get_bus_volume_db(MUSIC_BUS_ID)
	$SettingsContainer/SFXContainer/SFXSlider.value = AudioServer.get_bus_volume_db(SFX_BUS_ID)
	
	AudioServer.set_bus_volume_db(MASTER_BUS_ID, linear_to_db($SettingsContainer/MasterContainer/MasterSlider.value))
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db($SettingsContainer/MusicContainer/MusicSlider.value))
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db($SettingsContainer/SFXContainer/SFXSlider.value))

	
	$SettingsContainer/IDContainer/IDSlider.value = Globals.tts_voice_id
	$SettingsContainer/VoiceContainer/VoiceSlider.value = Globals.tts_volume_value
	$SettingsContainer/VoiceContainer/VoiceSlider2.value = Globals.tts_speed_value
	$SettingsContainer/VoiceContainer/VoiceSlider2.value = Globals.tts_speed_value

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		pauseMenu()

func pauseMenu():
	if paused:
		pause_menu.hide()
		DisplayServer.tts_resume()
	else:
		pause_menu.show()
		DisplayServer.tts_pause()
		
	paused = !paused

func _on_size_slider_value_changed(value: int) -> void:
	for nodes in get_tree().get_nodes_in_group("Text"):
		nodes.add_theme_font_size_override("font_size", value)

func _on_master_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(MASTER_BUS_ID, linear_to_db(value))

func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value))

func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
	# play example sfx

func _on_id_slider_value_changed(value: int) -> void:
	Globals.tts_voice_id = value
	# DisplayServer.tts_speak("Testing audio.", voice_id, volume_value, 1.0, speed_value)

func _on_voice_slider_value_changed(value: int) -> void:
	Globals.tts_volume_value = value
	# DisplayServer.tts_speak("Testing audio.", voice_id, volume_value, 1.0, speed_value)

func _on_voice_slider_2_value_changed(value: float) -> void:
	Globals.tts_speed_value = value
	# DisplayServer.tts_speak("Testing audio.", voice_id, volume_value, 1.0, speed_value)

func _on_settings_back_pressed() -> void:
	pauseMenu()

@export var main_menu_scene_name : String
func _on_settings_main_menu_pressed() -> void:
	DisplayServer.tts_stop()
	get_tree().change_scene_to_file(main_menu_scene_name)
	
func _on_contrast_slider_value_changed(value: float) -> void:
	for nodes in get_tree().get_nodes_in_group("Text"):
		nodes.add_theme_font_color_override("font_color", value)
