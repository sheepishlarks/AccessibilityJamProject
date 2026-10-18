extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func play_audio(audio_file: String):
	var new_audio = AudioStreamPlayer.new()
	add_child(new_audio)
	
	new_audio.stream = audio_file
	new_audio.finished.connect(new_audio.queue_free)
	new_audio.play()
