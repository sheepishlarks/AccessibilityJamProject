extends Resource
class_name SoundFX
enum SOUND_EFFECTS {
	CLICK,
	TICK
}

@export var type : SOUND_EFFECTS
@export var sound_effect : AudioStream
