extends Control

func _on_button_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)  
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)  
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)  
	
	# Ensure the game tree is not paused
	get_tree().paused = false

	# Change the scene to the main menu
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_h_slider_value_changed(value):
	AudioServer.set_bus_volume_db(0,value/3)
	if value == -50:
		AudioServer.set_bus_mute(0,true)
	else:
		AudioServer.set_bus_mute(0,false)
	BackgroundMusic.master_level = value
	

func _on_h_slider_value_changed_music(value):
	AudioServer.set_bus_volume_db(1,value/3)
	if value == -50:
		AudioServer.set_bus_mute(1,true)
	else:
		AudioServer.set_bus_mute(1,false)
	BackgroundMusic.menu_music_level = value


func _on_in_game_music_value_changed(value):
	AudioServer.set_bus_volume_db(2,value/3)
	if value == -50:
		AudioServer.set_bus_mute(2,true)
	else:
		AudioServer.set_bus_mute(2,false)
	BackgroundMusic.in_game_music_level = value


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://scenes/profile_options.tscn")
