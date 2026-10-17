extends Node

var last_played_string: String

# Called when the node enters the scene tree for the first time.
func process_command( input: String) -> String:
	var words = input.split(" ", false)
	if words.size() == 0:
		return "Error: no words were parsed"
	
	var first_word = words[0].to_lower()
	var second_word = ""
	if words.size() > 1:
		second_word = words[1].to_lower()
	
	match first_word:
		#directional movement
		"go":
			last_played_string = go(second_word)
			return last_played_string
		"forward", "f", "back", "b", "left", "l", "right", "r", "north", "n", "south", "s", "east", "e", "west", "w", "up", "u", "down", "d":
			last_played_string = go(first_word)
			return last_played_string
		
		#senses
		"smell", "touch", "feel", "taste", "listen", "hear":
			last_played_string = sense(first_word, second_word)
			return last_played_string
		
		#look
		"see", "look":
			last_played_string = "It is pitch black, you can't see anything."
			return last_played_string
		
		#define
		"define":
			last_played_string = define(words.slice(1))
			return last_played_string
		
		#player help
		"help", "h", "list":
			last_played_string = help()
			return last_played_string
		"stat", "status":
			last_played_string = status()
			return last_played_string
		"replay", "last", "repeat", "old":
			return last_played_string
		_:
			last_played_string = "Unrecognized command - please try again."
			return last_played_string
		

func go(second_word: String) -> String:
	match second_word:
		"north", "n", "forward", "f", "up", "u":
			return "You go north"
			
		"east", "e", "right", "r":
			return "You go east"
			
		"south", "s", "down", "d", "back", "b":
			return "You go south"
			
		"west", "w", "left", "l":
			return "You go west"
		_:
			return "Go where?"

func help() -> String:
	return "TEMP Command List: ect ect"

func status() -> String:
	return "TEMP you have defined x objects, there are still x to define. you are in a location with things in it"

func sense(sense: String, second_word: String):
	#is the second word a valid object?
	
	#what sense are you using?
	match sense:
		"smell":
			return "TEMP you smell %s" % second_word
		
		"touch", "feel":
			return "TEMP you touch %s" % second_word
		
		"taste":
			return "TEMP you taste %s" % second_word
		
		"hear", "listen":
			return "TEMP you hear %s" % second_word

func define(words: Array[String]) -> String:
	# check if object has already been defined
	
	# check there is a name of the object
	if words.size() == 0:
		return "Define what?"
		
	# get object name
	var Objectname = words[0]
	for i in (words.size() - 1):
		Objectname += " " + words[i+1]
	
	return "Before you is the %s" % Objectname
	
