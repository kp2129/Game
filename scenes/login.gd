extends Control

var http_request

func _ready():
	http_request = $HTTPRequest

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
	var headers = ["Content-Type: application/json"]
	var username = $Username.text
	var password = $Password.text
	var url = "http://localhost:8000/login"
	var body = {"username": username, "password": password}
	body = JSON.stringify(body)
	var error = http_request.request(url, headers, true, HTTPClient.METHOD_POST, body)
	if error != OK:
		push_error("An error occurred in the HTTP request")
