extends VBoxContainer

func set_text(input: String, response: String): 
	$InputHistory.text = " > " + input
	$Response.text = response 

func set_response_text(response: String): 
	$Response.text = response
