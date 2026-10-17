extends Control

const Response = preload("res://accessibility-jam/UI/response.tscn")
const InputResponse = preload("res://accessibility-jam/UI/input_response.tscn")

@export var max_lines_remembered := 30
@export var message = "enter starting message here!"

@onready var history_rows = $Background/MarginContainer/Rows/GameInfo/ScrollContainer/HistoryRows
@onready var command_processor = $CommandProcessor

func _ready() -> void: 
	var starting_message = Response.instantiate() 
	starting_message.text = message
	add_response_to_game(starting_message)
	
@onready var pause = $SettingsLayer
@onready var play_click = $ClickPlayer

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Escape"):
		pause.show()

func _on_input_text_submitted(new_text: String) -> void:
	if new_text.is_empty(): 
		return
		
	var input_response = InputResponse.instantiate()
	var response = command_processor.process_command(new_text)
	input_response.set_text(new_text, response)
	add_response_to_game(input_response)
	#history_rows.add_child(input_response)
	
	play_click.play()

func delete_history_beyond_limit(): 
	if history_rows.get_child_count() > max_lines_remembered:
		var rows_to_forget = history_rows.get_child_count() - max_lines_remembered
		for i in range(rows_to_forget):
			history_rows.get_child(i).queue_free()
			

func add_response_to_game(response: Control): 
	history_rows.add_child(response)
	delete_history_beyond_limit()
	
