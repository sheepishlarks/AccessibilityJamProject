extends Node

signal response_generated(response_text)

var last_played_string: String
var current_room = null

#definitions 
var windowDef = "something else..."
var deskDef = "something"

func initialise(starting_room) -> String: 
	return change_room(starting_room)
	
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
			
		#easter eggs
		"xyzzy":
			last_played_string = "'xyzzy' buzzes a bee as it flys by your ear."
			return last_played_string	
			
		"man":
			last_played_string = "a miserable little pile of secrets."
			return last_played_string	
		
		"slander":
			last_played_string = "slander is spoken. in print, it's libel."
			return last_played_string	
		
		"haggis":
			last_played_string = "ueee ueeeueueee uee uuu uueeee"
			return last_played_string
		
		"disco":
			last_played_string = """SHIVERS [Medium: Success] – Somewhere across the world, on
			an isola that is still unobscured by entropic fog, one man is dying, 
			and another is waking up for the first time in his life.
			
			YOU – Who is the man?
			
			KIM KITSURAGI – Detective? You've been standing there for 5
			minutes. Let's get back to work."""
			return last_played_string
		
		"dance":
			last_played_string = "You dance."
			return last_played_string
		
		
		#else
		_:
			last_played_string = "Unrecognized command - please try again."
			return last_played_string
		

func go(second_word: String) -> String:
		
	match second_word:
		"north", "n", "forward", "f", "up", "u":
			if current_room.exits.keys().has("north"):
				var change_response = change_room(current_room.exits["north"])
				return "You go north" + "\n" + change_response
			else:
				return "whoops thats a wall"
			
		"east", "e", "right", "r":
			if current_room.exits.keys().has("east"):
				var change_response = change_room(current_room.exits["east"])				
				return "You go east" + "\n" + change_response
			else:
				return "whoops thats a wall"
			
		"south", "s", "down", "d", "back", "b":
			if current_room.exits.keys().has("south"):
				var change_response = change_room(current_room.exits["south"])
				return "You go south" + "\n" + change_response
			else:
				return "whoops thats a wall"
			
		"west", "w", "left", "l":
			if current_room.exits.keys().has("west"):
				var change_response = change_room(current_room.exits["west"])
				return "You go west" + "\n" + change_response
			else:
				return "whoops thats a wall"
		_:
			return "Go where?"

func help() -> String:
	return "TEMP Command List: ect ect"

func status() -> String:
	return "TEMP you have defined x objects, there are still x to define. you are in a location with things in it"

func sense(sense: String, second_word: String):
	#is the second word a valid object?
	if current_room.roomItems.has(second_word): 
		match second_word:
			"piss": 
				return "you smell piss. guess this flat is in dundee"
	elif second_word == "": 
		pass
	else:
		return "You can't smell that."
		
	#what sense are you using?
	match sense:
		"smell":
			#return "TEMP you smell %s" % second_word
			match current_room.room_name: 
				"South": 
					return "The paint is so incredibly old it barely smells of anything at all, but you can make out hints of oak hiding beneath it. "
				"Centre": 
					return "It’s faint, but there’s a slight waft of some food-smell coming from the southwest corner."
				"North": 
					return "The air has that post-bonfire smell that seems to come around at night. It’s lightly smoky, accented nicely by the cool, October temperatures."
				"North East": 
					return "You smell something cheap and fresh, like an aerosol to cover up the scent that years of dust leaves behind. There’s also a distinct leathery scent that you believe might be a 'chair'"
				"East": 
					return "You smell a mix of old paper and waxy plastic. The two comingle unhappily but are clearly inseparable."
				"South East":
					return "You smell well-loved cedar. It’s comforting."
				"South West": 
					return "Something unidentifiable wafts in the air. It smells like something that’s been cooking low and slow for quite some time. You catch a hint of some 'spices' that seem to have been laid out close by."
				"West": 
					return "The air here is stale, far more stale than the rest of the room. It’s a little unsettling."
				"North West": 
					return "This place smells like sweat, and not really much else."
				_: 
					return "TEMP you smell %s" % second_word
				
		"touch", "feel":
			match current_room.room_name: 
				"South": 
					return "It’s solid and sturdy. It’s certainly never been broken into. Your hand finds a latch-chain that (luckily for you) was left unconnected."
				_: 
					return "TEMP you touch %s" % second_word
		
		"taste":
			match current_room.room_name: 
				"South": 
					return "You taste the thousands of hands that have touched this before. Gives a whole new meaning to ‘a new lick of paint’."
				_: 
					return "TEMP you taste %s" % second_word
		
		"hear", "listen":
			match current_room.room_name: 
				"South": 
					return "You hear faint chatter and yelling from further down the stairwell, but the wood is too thick for you to hear what anyone is talking about."
				_: 
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
	

func change_room(new_room: Room) -> String: 
	current_room = new_room
	var exit_string = PackedStringArray([new_room.exits.keys()])
	#var exit_string2.join(exit_string)
	var strings = new_room.room_description + "\n" + "Exits: " + " ".join(exit_string)
	#emit_signal("response_generated", strings)
	return strings

func use_senses(smelled: String) -> String: 
	return smelled
