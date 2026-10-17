extends Control

const InputResponse = preload("res://accessibility-jam/UI/input_response.tscn")

@onready var history_rows = $Background/MarginContainer/Rows/GameInfo/ScrollContainer/HistoryRows


func _on_input_text_submitted(new_text: String) -> void:
	var input_response = InputResponse.instantiate()
	input_response.set_text(new_text, "This is where a response would go.")
	history_rows.add_child(input_response)
