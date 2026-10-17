extends Control

const Response = preload("res://accessibility-jam/UI/response.tscn")
const InputResponse = preload("res://accessibility-jam/UI/input_response.tscn")

@export var max_lines_remembered := 30
@export var message = "enter starting message here!"

@onready var history_rows = $Background/MarginContainer/Rows/GameInfo/ScrollContainer/HistoryRows
@onready var command_processor = $CommandProcessor
@onready var room_manager = $RoomManager

@onready var pause = $SettingsLayer
@onready var play_click = $ClickPlayer

@onready var tts_id: int = $SettingsLayer/Settings.id_value
@onready var tts_volume: int = $SettingsLayer/Settings.volume_value
@onready var tts_speed: float = $SettingsLayer/Settings.speed_value

var voices = DisplayServer.tts_get_voices_for_language("en")
var voice_id = voices[tts_id]

func _ready() -> void:
	
	#var starting_message = Response.instantiate() 
	#starting_message.text = message
	#add_response_to_game(starting_message)
	handle_response_generated(message)
	command_processor.response_generated.connect(handle_response_generated)
	var starting_room_response = command_processor.initialise(room_manager.get_child(1))
	handle_response_generated(starting_room_response)
	var starting_message = Response.instantiate()
	# var start_message: String = message
	starting_message.text = message
	#add_response_to_game(starting_message)

	#add_response_to_game(starting_message)
	
	DisplayServer.tts_speak(message, voice_id, tts_volume, 1.0, tts_speed)


func _on_input_text_submitted(new_text: String) -> void:
	if new_text.is_empty(): 
		return
	
	var input_response = InputResponse.instantiate()
	var response = command_processor.process_command(new_text)
	input_response.set_text(new_text, response, 1, tts_volume, tts_speed)
	add_response_to_game(input_response)
	#history_rows.add_child(input_response)
	
#<<<<<<< HEAD
func handle_response_generated(response_text: String): 
	var response = Response.instantiate() 
	response.text = response_text
	add_response_to_game(response)
#=======
	play_click.play()
#>>>>>>> 86f4d3a42f3b98f755167f94c988200248746450

func delete_history_beyond_limit(): 
	if history_rows.get_child_count() > max_lines_remembered:
		var rows_to_forget = history_rows.get_child_count() - max_lines_remembered
		for i in range(rows_to_forget):
			history_rows.get_child(i).queue_free()
			

func add_response_to_game(response: Control): 
	history_rows.add_child(response)
	delete_history_beyond_limit()
	
