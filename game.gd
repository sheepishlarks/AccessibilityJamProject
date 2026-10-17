extends Control

const InputResponse = preload("res://accessibility-jam/UI/input_response.tscn")

@export var max_lines_remembered := 30

@onready var history_rows = $Background/MarginContainer/Rows/GameInfo/ScrollContainer/HistoryRows




func _on_input_text_submitted(new_text: String) -> void:
	if new_text.is_empty(): 
		return
		
	var input_response = InputResponse.instantiate()
	input_response.set_text(new_text, "This is where a response would go.")
	history_rows.add_child(input_response)

	if history_rows.get_child_count() > max_lines_remembered:
		var rows_to_forget = history_rows.get_child_count() - max_lines_remembered
		for i in range(rows_to_forget):
			history_rows.get_child(i).queue_free()
