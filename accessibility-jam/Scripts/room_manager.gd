extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$South.connect_exit("north", $Centre)
	$Centre.connect_exit("north", $North)
	$North.connect_exit("south", $Centre)
	$Centre.connect_exit("south", $South)
