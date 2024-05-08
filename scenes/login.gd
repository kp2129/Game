extends Control

var user_token = ""
var username = ""
var user_id = ""

var http_request

func _on_back_pressed():
	# Ensure input processing is reset
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

	# Ensure the game tree is not paused
	get_tree().paused = false

	# Change the scene to the main menu
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_register_pressed():
	get_tree().change_scene_to_file("res://scenes/register.tscn")

func _on_login_pressed():
	$HTTPRequest.request_completed.connect(_on_http_request_request_completed)
	var headers = ["Content-Type: application/json"]
	var username = $Username.text
	var password = $Password.text
	var url = "http://localhost/rgame/backend/login.php"
	var body = {"username": username, "password": password}
	body = JSON.stringify(body)
	# Set a timeout for the HTTP request (in seconds)
	$HTTPRequest.timeout = 10
	$HTTPRequest.request(url, headers, HTTPClient.METHOD_POST, body)

func _on_http_request_request_completed(result, response_code, headers, body):

	if result == OK:
		if response_code == 200:
			var json = JSON.parse_string(body.get_string_from_utf8())
			print("Login successful")
			user_token = json["token"]
			username = json["data"]["username"]
			UserManager.instance.user_token = user_token
			UserManager.instance.username = username
			get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
		else:
			var json = JSON.parse_string(body.get_string_from_utf8())
			print("Login failed")
			$ErrorLabel.text = json["error"]

	else:
		# Handle errors, such as connection timeout or server not reachable
		print("HTTP request failed:", result)
		$ErrorLabel.text = "Error: Server unreachable"
