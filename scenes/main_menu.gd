extends Control


func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_options_pressed():
	get_tree().change_scene_to_file("res://scenes/options.tscn")

func _on_shop_pressed():
	get_tree().change_scene_to_file("res://scenes/shop.tscn")

func _on_quit_pressed():
	get_tree().quit()


func _on_stats_pressed():
	get_tree().change_scene_to_file("res://scenes/statistics.tscn")
