extends Node

var sound_effect_dict = {}

@export var sound_effects_settings : Array[SoundFX]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func play_audio(type : SoundFX.SOUND_EFFECTS):
	if sound_effect_dict.has(type):
		var sound_effect_setting: SoundFX = sound_effect_dict[type]
		var new_audio = AudioStreamPlayer.new()
		add_child(new_audio)
		new_audio.stream = sound_effect_setting
		new_audio.play()
