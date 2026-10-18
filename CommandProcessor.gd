extends Node

signal response_generated(response_text)

var last_played_string: String
var current_room = null


#definitions 
var windowDef = "something else..."
var deskDef = "something else..."
var bookshelfDef = "something else..."
var wardrobeDef = "something else..."
var doorDef = "What are those things called again? The swingy-open things, the ones you put the keys in. Maybe that should be the first thing in the room that you [define]."
var stoveDef = "something else..."
var shelfDef = "something else..."
var bedDef = "something else..."

# special variables 
var curtainsOpen = false 
var panSpiced = false;

var voices = DisplayServer.tts_get_voices_for_language("en")
var voice_id = voices[0]


func initialise(starting_room) -> String: 
	return change_room(starting_room)
	DisplayServer.tts_speak(starting_room, voice_id, 50, 1.0, 1)
	
# Called when the node enters the scene tree for the first time.
func process_command( input: String) -> String:
	input = remove_punctuation(input)
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
			last_played_string = feel(first_word, second_word)
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
			
		#interact 
		"open": 
			match second_word: 
				"curtain", "curtains": 
					if current_room.room_name == "North":
						curtainsOpen = true
						last_played_string = "You open the curtains, but it’s pitch dark outside, save for the twinkling of stars in the sky. Regardless, the room is made no brighter for it. You can just barely make out the silhouette of a 'plant' pot against the outside."
						return last_played_string
					else: 
						last_played_string = "You can't find any curtains."
						return last_played_string
				_: 
					last_played_string = "Open what?"
					return last_played_string
		"close", "shut": 
			match second_word: 
				"curtain", "curtains": 
					if current_room.room_name == "North":
						curtainsOpen = false
						last_played_string = "You close the curtains. Its dark. Like always."
						return last_played_string
					else: 
						last_played_string = "You can't find any curtains."
						return last_played_string
				_: 
					last_played_string = "Open what?"
					return last_played_string
		
		"talk", "speak": 
			match second_word:
				"plant": 
					if current_room.room_name == "North": 
						if curtainsOpen == false: 
							last_played_string = "The plant, audibly excited, says “Hello!” in a voice so muffled that you can barely hear it."
							return last_played_string
						else: 
							last_played_string = "The plant, audibly excited, says “Hello!” back to you in a tiny voice."
							return last_played_string
					else: 
						last_played_string = "It can't hear you, and you can't hear it. A lonely existence for both of you."
						return last_played_string
				"": 
					last_played_string = "Talk to who?"
					return last_played_string
				_: 
					last_played_string = "No one to hear you scream."
					return last_played_string		
				
		"use": 
			match second_word: 
				"spices": 
					if current_room.room_name == "South West": 
						last_played_string = "You stir the spices into the pan. Into the pan of mystery stew in someone's abandoned flat. Look, you didn't have time to eat before this!"
						return last_played_string
					else: 
						last_played_string = "What spices?"
						return last_played_string
				_: 
					last_played_string = "Use what?"
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

func feel(sense: String, second_word: String):
	#is the second word a valid object?
	if current_room.roomItems.has(second_word): 
		match second_word:
			"piss": 
				return "you smell piss. guess this flat is in dundee"
			"curtains": 
				match sense: 
					"smell": 
						return "You breathe in a bit too deeply and get a nose full of old smoke. These will need a wash before the apartment can sell."
					"touch", "feel": 
						return "The material feels light and slightly coarse, with two or three layers of fabric to it. You guess that they might be linen or cotton."
					"taste": 
						return "A little dry for your taste. Too difficult to rip a bite from, and bits of fabric get stuck in your teeth. You make a mental note not to eat here again."
					"listen", "hear": 
						return "You hear a breeze rustling the fabric back and forth. It reminds you of a swinging pendulum."
			"plant": 
				match sense: 
					"smell": 
						if curtainsOpen == true: 
							return "Smells a little bit like wet soil."
						else:
							return "The smoky smell of the curtain is too overpowering to get past."
					"touch", "feel": 
						if curtainsOpen == true: 
							return "You can feel a large number of cool, smooth strands growing out in all directions."
						else:
							return "Well, it feels like there’s a plant *behind* the curtain, but any details are impossible to make out."
					"taste": 
						if curtainsOpen == true: 
							return "Well that’s kind of playing with fire, isn’t it? What if this is one of those *toxic house plants*?"
						else:
							return "That’s just curtain again, buddy."
					"listen", "hear": 
						if curtainsOpen == true: 
							return "The plant isn’t saying anything, but to be fair, it’s not like you’re talking to it right now either."
						else:
							return "The plant isn’t saying anything, but even if it was, it would be difficult to hear with the curtain in the way."
			"chair": 
				match sense: 
					"smell": 
						return "Well, it certainly *smells* like someone has spent a lot of time sitting here. For better or for worse."
					"touch", "feel": 
						return "The mix of mesh and backboard feel very ergonomic, and the leather is the real deal. This thing is expensive."
					"taste": 
						return "You gently nibble on the topmost part of the seat, which tastes undeniably like what the inside of an IKEA feels like. A word flashes in your mind: BÄSTBOLL."
					"listen", "hear": 
						return "The chair rolls a little in the darkness, lightly swivelling lightly back and forth. "
			"computer": 
				match sense:
					"smell": 
						return "Something smells a little acrid, but you quickly realise it’s probably the work of some type of machinery."
					"touch", "feel": 
						return "The computer’s surface is matte and emits a week heat. You can feel little bumps in its design, but they don’t seem to do anything."
					"taste": 
						return "You get a sharp shock to your tongue. You would ideally prefer *not* to do that again, but could see it happening if the urge overtook you once more."
					"listen", "hear": 
						return "There’s a gentle, consistent whir. Every so often a little beep intersperses with the sound."		
			"books": 
				match sense: 
					"smell": 
						return "You pick up a book that smells brand-new, like it’s only just been bought."
					"touch", "feel": 
						return "You pick up a book whose pages are worn. Whoever lived here last must be missing it now."
					"taste": 
						return "You pick up a book and take a tentative bite out of it. Tastes like eating a muffin wrapper, but bad."
					"listen", "hear": 
						return "You pick up a book and hear that its pages are rustling. Must’ve been the wind?"
			"pan": 
				match sense: 
					"smell": 
						if panSpiced == true: 
							return "Now that’s more like it! A rich aroma fills the air. It smells like heaven!"
						else: 
							return "Whatever’s cooking, it smells good. Since the original tenant’s gone, it’s probably free rein – right?"
					"touch", "feel": 
						return "You shoogle the handle of the pan a little, carefully so that you don’t accidentally spill anything."
					"taste": 
						if panSpiced == true: 
							return "For the briefest of moments, you are no longer standing in a pitch-dark, recently abandoned studio apartment. You feel yourself *exiting* yourself, rising higher and higher, beyond the slit in the North wall where the noise comes in and up, up, up, ever higher. The sky opens itself to you; a stellar, sparkling vista that has long been waiting for the culinarily enlightened to join their midst. You begin to lose track of the time, spending what might be hours or what might be years savouring this single, blessed flavour. And then in a blink it’s over. You’re back in the dark, with a job to do. But *damn* was that good. "
						else: 
							return "…Hmm. It smells better than it tastes. It’s thick, like a curry or a kind of stew, but it’s almost certainly missing something."
					"listen", "hear": 
						return "Something is bubbling away leisurely. An intense electrical hum is emanating from underneath the pan."					
			"spices": 
				match sense: 
					"smell": 
						return "You smell every spice, all at once. It is simultaneously heavenly and overwhelming. Your eyes water a little, but you weren’t exactly using them right now anyway."
					"touch", "feel": 
						return "Each individual container feels weighty and well-stocked for how little they are."
					"taste": 
						return "Some of these taste a lot nicer on their own than others. It doesn’t matter which you enjoyed the most, every flavour gives way to an all-consuming peppery heat."
					"listen", "hear": 
						return "All is quiet on the cayenne front. And the salt, pepper, paprika, oregano, basil, parsley, and thyme front. Honestly, you’re just intuiting these names based on each spice’s unique brand of silence."	
			"crystal ball": 
				match sense: 
					"smell": 
						return "You sniff really, really hard, but it just smells like pondering the orb."
					"touch", "feel": 
						return "You feel a curved, glassy surface. It’s big, bigger than your hand, and it’s completely smooth the whole way round. There’s an odd chill to it that isn’t congruent with the temperature of the room."
					"taste": 
						return "Your mouth is full of ‘crystal’. It tastes like knowledge and regret. And a little bit like sugar. "
					"listen", "hear": 
						return "Are those whispering noises kinda eerie? Are they saying something? Or have you just not gotten enough sleep?"	
			"plushie": 
				match sense: 
					"smell": 
						return "Breathing in the scent of the bear’s fur feels invasive, like you’re stealing it from somebody else."
					"touch", "feel": 
						return "There’s a softness to the bear that makes you feel a little vulnerable. You don’t want to let go."
					"taste": 
						return "It tastes like new soap, and like a love to outlive the ages. Somebody was clearly invested in keeping this little guy in good condition."
					"listen", "hear": 
						return "This little toy bear can’t talk, but the silence holds a thousand memories."	
			"blankets": 
				match sense: 
					"smell": 
						return "Breathing in the scent of the bear’s fur feels invasive, like you’re stealing it from somebody else."
					"touch", "feel": 
						return "You’ve never felt anything so fluffy, almost sheeplike. You would take it home with you if being found out wouldn’t get you fired on the spot"
					"taste": 
						return "You thoughtfully ponder the taste of the blankets. It’s not the worst you’ve ever tried, but it’s not the best, either. You settle on a 6/10."
					"listen", "hear": 
						return "You could swear that the blankets and pillows are inviting you to lie down. The urge to flop onto them is overwhelming, but you have to persist whilst the job is incomplete. "
	elif second_word == "": 
		pass
	elif second_word == current_room.room_name:
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
				"North": 
					if curtainsOpen == false:
						return "You feel a weighty length of fabric, split down the middle vertically. These are probably 'curtains'!"
					else: 
						return "You feel a sheet of flat, slightly scuffed glass. It’s cool to the touch, and a slight breeze escapes from it."
				"North East": 
					return "Whatever’s here is large and flat, with sharply defined edges and a surface marred with scuff marks. You can feel its size by running your hand over it, as well as the fact that a 'computer' seems to be situated here."
				"East": 
					return "You reach towards a space that you think *might* be full, but meet with empty air until you waggle your hand a little more in either direction. The things that you settle on are almost certainly 'books'."
				"South East": 
					return "You run your hand over glossy wood and make your way to a handle. It opens with little give, and inside you feel what must be 'clothes'."
				"South West": 
					return "Your hand glides across some sort of sleek and cool countertop. It stops just short of a ‘hotspot’ (luckily for your hand), where you find the handle of a 'pan' sticking out. "
				"West": 
					return "Whatever’s in front of you, it has been recently painted. You can feel bumpy, clashing textures denoting a bit of a hack-job, but it does what it needs to. The furniture itself is attached directly to the wall, and feels layered, like it repeats itself. On top of one of its layers, you feel what you can only assume to be a 'crystal ball'."
				"North West": 
					return "There’s something here that’s springy and soft, but it’s got a few uncomfortable dents. On top of it you can feel 'blankets', and something that feels undeniably like a stuffed bear 'plushie'."
				"Centre": 
					return "If you stretch your arms out and spin, you can’t feel anything in any direction. There’s a slight chill descending from above."
				_: 
					return "TEMP you touch %s" % second_word
		
		"taste":
			match current_room.room_name: 
				"South": 
					return "You taste the thousands of hands that have touched this before. Gives a whole new meaning to ‘a new lick of paint’."
				"North": 
					return "It’s practically tasteless – like metal, but not quite. Don’t try to pretend like you’ve never tasted metal before!"
				"North East": 
					return "A dull, chemical taste spreads across your tongue and lingers in your throat. It’s not dangerous, but now you know how cats must feel. "
				"East": 
					return "You get a bad feeling about licking a place of knowledge? You don’t know how you know it’s a place of knowledge."
				"South East": 
					return "As you stick out your tongue, you get a mix of cotton and non-bio laundry detergent."
				"South West": 
					return "Going by the smell, you would have expected this to taste better. Instead, it’s cold and flavourless, save for a disparate sprinkling of abandoned crumbs, some notably more ancient than others, but almost all burned. Blegh."
				"West": 
					return "You barely notice the taste of the paint before you find a splinter the job didn’t catch. Yowza! Guess you’d better file an injury-at-work report. "
				"North West": 
					return "You’re greeted with the unpleasant taste of week-old oil from a ramen packet."
				"Centre": 
					return "Nothing. Nothing at all."				
				_: 
					return "TEMP you taste %s" % second_word
		
		"hear", "listen":
			match current_room.room_name: 
				"South": 
					return "You hear faint chatter and yelling from further down the stairwell, but the wood is too thick for you to hear what anyone is talking about."
				"North": 
					return "Down below at the street level, there is an occasional shriek, whoop, or scream that carries its way up to the room you’re standing in. Slightly higher, you can hear birds cawing back and forth."
				"North East": 
					return "There’s something here, but if you had to personify it, you’d hazard that it’s grumpy and there’s heavy stuff on it. It’s not talking to you."
				"East": 
					return "Whatever this thing is, you feel like it’s got some stories to tell..."
				"South East": 
					return "If these wardrobes could talk..."
				"South West": 
					return "You can hear a faint humming of electricity."
				"West": 
					return "You hear the gentle unrest of long-fallen dust, like a miniature desert."
				"North West": 
					return "You swear you can hear the sound of a mattress still puffing up after a night’s sleep. The former tenant must’ve skedaddled only moments before you arrived. "
				"Centre": 
					return "Away from the walls, you don’t hear much. There’s a ‘fwsh, fwsh’ sort of sound overhead, and the faint ticking of a clock coming from the wall to the west."				
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
		
	match current_room.room_name: 
		"North": 
			if windowDef == "something else...": 
				windowDef = Objectname
			else: 
				return "You already defined it! That's a " + windowDef
		"South": 
			if doorDef == "What are those things called again? The swingy-open things, the ones you put the keys in. Maybe that should be the first thing in the room that you [define]": 
				doorDef = Objectname
			else: 
				return "You already defined it! That's a " + doorDef
		"South East": 
			if wardrobeDef == "something else...": 
				wardrobeDef = Objectname
			else: 
				return "You already defined it! That's a " + wardrobeDef
		"South West": 
			if stoveDef == "something else...": 
				stoveDef = Objectname
			else: 
				return "You already defined it! That's a " + stoveDef
		"North East": 
			if deskDef == "something else...": 
				deskDef = Objectname
			else: 
				return "You already defined it! That's a " + deskDef
		"North West": 
			if bedDef == "something else...": 
				bedDef = Objectname
			else: 
				return "You already defined it! That's a " + bedDef
		"Centre": 
			return "There is nothing here to define."
		"East": 
			if bookshelfDef == "something else...": 
				bookshelfDef = Objectname
			else: 
				return "You already defined it! That's a " + bookshelfDef
		"West": 
			if shelfDef == "something else...": 
				shelfDef = Objectname
			else: 
				return "You already defined it! That's a " + shelfDef
	
	return "Before you is the %s" % Objectname
	

func change_room(new_room: Room) -> String: 
	current_room = new_room
	var exit_string = PackedStringArray([new_room.exits.keys()])
	#var exit_string2.join(exit_string)
	var strings = new_room.room_description + "\n" + "Exits: " + " ".join(exit_string)
	#emit_signal("response_generated", strings)
	return strings
	
	
func remove_punctuation(input: String) -> String:
	var fixed_string: String = input
	var punctuation = [",", ".", "!", "?"]
	for p in punctuation:
		fixed_string = fixed_string.replace(p, "")
	return fixed_string

func use_senses(smelled: String) -> String: 
	return smelled
