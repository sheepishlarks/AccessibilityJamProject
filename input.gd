extends LineEdit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grab_focus()

func focus() -> void: 
	grab_focus()

func _on_text_submitted(new_text: String) -> void:
	clear()

func _process(delta: float) -> void:
		editable = true
		selecting_enabled = true

func _on_editing_toggled(toggled_on: bool) -> void:
	if toggled_on == false:
		print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
		editable = true
		selecting_enabled = true
		edit()
	else:
		print("yayayayayyayayayayayyayayayayyayayyayayayayyay")
