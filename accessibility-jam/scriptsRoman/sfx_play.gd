extends Node

@onready var audio_player = $AudioStreamPlayer

func _on_pressed() -> void:
	audio_player.play()
