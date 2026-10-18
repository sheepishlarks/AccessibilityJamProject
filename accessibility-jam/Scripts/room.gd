extends Node

class_name Room

@export var room_name = "roomName"
@export var room_description = "this is the description of the room"
@export var room_description_defined = "this is the new description of the room"
@export var roomItems = ["Unobject"]


var exits: Dictionary = {}
var room_defined = false 

func connect_exit(direction: String, room: Room): 
	match direction: 
		"west": 
			exits[direction] = room
			room.exits["east"] = self
		"east": 
			exits[direction] = room
			room.exits["west"] = self	
		"north": 
			exits[direction] = room
			room.exits["south"] = self
		"south": 
			exits[direction] = room
			room.exits["north"] = self	
		_: 
			printerr("Tried to connect to invalid direction: %s", direction)
			
func define_room(definition: String): 
	room_defined = true
	room_description_defined = room_description_defined + definition
