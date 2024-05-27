extends Control

var http_request

# Called when the node enters the scene tree for the first time.
func _ready():
	http_request = $HTTPRequest
	http_request.request_completed.connect(_on_http_request_request_completed)
	var url = "https://kp2129.com/leaderboard.php"
	var headers = []
	http_request.request(url, headers, HTTPClient.METHOD_GET)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_http_request_request_completed(result, response_code, headers, body):
	if result == OK:
		if response_code == 200:
			var json = JSON.parse_string(body.get_string_from_utf8())
			if json.has("top_users"):
				var top_users = json["top_users"]
				print(top_users)
				_display_top_users(top_users)
			else:
				print("No top users found in response")
		else:
			print("Failed to get top users. Response code:", response_code)
	else:
		print("HTTP request failed:", result)

func _display_top_users(top_users):
	# Clear existing text and check if the labels exist
	var labels = [$first, $second, $third, $fourth, $fifth]

	for i in range(labels.size()):
		if labels[i]:
			labels[i].text = ""

	# Set the text for each label if the user exists and the label is found
	for i in range(min(top_users.size(), labels.size())):
		var user_data = top_users[i]
		print("Displaying user:", user_data["username"], "with top score:", user_data["top_score"])
		if labels[i]:
			labels[i].text = str(i+1) + ". " + user_data["username"] + " - " + str(user_data["top_score"])




func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
