extends Control

@export var settings: Settings
@export var scene_name : String

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file(scene_name)

func _on_settings_pressed() -> void:
	settings.pauseMenu()

func _on_quit_pressed() -> void:
	get_tree().quit()
