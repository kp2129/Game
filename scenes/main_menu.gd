extends Control

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	BackgroundMusic.audioplayer.stop()

func _on_options_pressed():
	get_tree().change_scene_to_file("res://scenes/Options.tscn")

func _on_shop_pressed():
	get_tree().change_scene_to_file("res://scenes/shop.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_stats_pressed():
	get_tree().change_scene_to_file("res://scenes/statistics.tscn")


func _on_leaderboard_pressed():
	get_tree().change_scene_to_file("res://scenes/leaderboard.tscn")
