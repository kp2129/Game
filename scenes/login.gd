extends Control

func _on_back_pressed():
	# Ensure input processing is reset
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

	# Ensure the game tree is not paused
	get_tree().paused = false

	# Change the scene to the main menu
	get_tree().change_scene("res://scenes/main_menu.tscn")

func _on_register_pressed():
	get_tree().change_scene("res://scenes/register.tscn")

func _on_login_pressed():
	$HTTPRequest.request_completed.connect(_on_http_request_request_completed)
	var headers = ["Content-Type: application/json"]
	var username = $Username.text
	var password = $Password.text
	var url = "http://localhost/rgame/backend/login.php"
	var body = {"username": username, "password": password}
	body = JSON.stringify(body)
	$HTTPRequest.request(url, headers, HTTPClient.METHOD_POST, body)

func _on_http_request_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	print(json)

