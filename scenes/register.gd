extends Control

var username = ""
var password

var created = false

func _on_back_2_pressed():
	# Ensure input processing is reset
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)  
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)  
	
	# Ensure the game tree is not paused
	get_tree().paused = false

	# Change the scene to the main menu
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
func _on_login_pressed():
	get_tree().change_scene_to_file("res://scenes/login.tscn")

func _on_login_button_down():
	var headers = ["Content-Type: application/json"]
	var username = $Username2.text
	var password = $Password3.text
	var rpassword = $Password4.text
	var url = "http://localhost/rgame/backend/register.php"
	var body = {"username": username, "password": password, "rpassword" : rpassword}
	body = JSON.stringify(body)
	# Set a timeout for the HTTP request (in seconds)
	$HTTPRequest.timeout = 10
	$HTTPRequest.request(url, headers, HTTPClient.METHOD_POST, body)

func _on_http_request_request_completed(result, response_code, headers, body):
	if result == OK:
		var json = JSON.parse_string(body.get_string_from_utf8())
		print(json)
		print(result)
		print(response_code)
		if response_code == 201:
			get_tree().change_scene_to_file("res://scenes/login.tscn")
		else:
			$ErrorLabel.text = json["error"]
	else:
		# Handle errors, such as connection timeout or server not reachable
		print("HTTP request failed:", result)
		$ErrorLabel.text = "Error: Server unreachable"
