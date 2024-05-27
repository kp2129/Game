extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_edit_button_down():
	var headers = ["Content-Type: application/json"]
	var username = $Username2.text
	var newusername = $Username3.text
	var url = "https://kp2129.com/edit.php"
	var body = {"username": username, "newusername": newusername}
	body = JSON.stringify(body)
	$HTTPRequest.timeout = 10
	$HTTPRequest.request(url, headers, HTTPClient.METHOD_POST, body)

func _on_http_request_request_completed(result, response_code, headers, body):
	if result == OK:
		var json = JSON.parse_string(body.get_string_from_utf8())
		print(json)
		print(result)
		print(response_code)
		if response_code == 200:
			$ErrorLabel.text = json["message"]
		else:
			$ErrorLabel.text = json["error"]
	else:
		# Handle errors, such as connection timeout or server not reachable
		print("HTTP request failed:", result)
		$ErrorLabel.text = "Error: Server unreachable"


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_edit_2_button_down():
	var headers = ["Content-Type: application/json"]
	var username = $Password5.text
	var oldpassword = $Password3.text
	var newpassword = $Password4.text
	var url = "https://kp2129.com/editPassword.php"
	var body = {"username": username, "oldpassword": oldpassword, "newpassword": newpassword}
	body = JSON.stringify(body)
	$HTTPRequest.timeout = 10
	$HTTPRequest.request(url, headers, HTTPClient.METHOD_POST, body)
