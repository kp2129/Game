extends Control



func _on_back_pressed():
	# Ensure input processing is reset
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)  
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)  
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)  
	
	# Ensure the game tree is not paused
	get_tree().paused = false

	# Change the scene to the main menu
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
func _on_register_pressed():
	get_tree().change_scene_to_file("res://scenes/register.tscn")
