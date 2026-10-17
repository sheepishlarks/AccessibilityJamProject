extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$South.connect_exit("north", $Centre)
	$South.connect_exit("east", $SouthEast)
	$South.connect_exit("west", $SouthWest)
	
	$Centre.connect_exit("north", $North)
	$Centre.connect_exit("east", $East)
	$Centre.connect_exit("west", $West)
	
	$North.connect_exit("east", $NorthEast)
	$North.connect_exit("west", $NorthWest)
	
	$SouthEast.connect_exit("north", $East)
	
	$SouthWest.connect_exit("north", $West)
	
	$East.connect_exit("north", $NorthEast)
	
	$West.connect_exit("north", $NorthWest)
	#$North.connect_exit("south", $Centre)
	#$Centre.connect_exit("south", $South)
