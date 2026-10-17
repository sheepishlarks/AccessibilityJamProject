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
			return go(second_word)
		"forward", "f", "back", "b", "left", "l", "right", "r", "north", "n", "south", "s", "east", "e", "west", "w":
			return go(first_word)
		
		#senses
		"smell", "touch", "feel", "taste", "listen", "hear":
			return sense(first_word, second_word)
		
		#player help
		"help", "h":
			return help()
		"replay":
			return replay()
		_:
			return "Unrecognized command - please try again."
		

func go(second_word: String) -> String:
	if second_word == "":
		return "Go where?"
		
	return "You go %s" % second_word
	
func help() -> String:
	return "Command List: ect ect"
	
func replay() -> String:
	return last_played_string

func sense(sense: String, second_word: String):
	#is the second word a valid object?
	#what sense are you using?
	return "you %s %s" % [sense, second_word]
