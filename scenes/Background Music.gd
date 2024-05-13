extends Node

var master_level
var menu_music_level
var in_game_music_level
var options

var audioplayer = AudioStreamPlayer2D.new()

func _ready():
	audioplayer.set_stream(preload("res://Dark Souls - Menu Theme.mp3"))
	audioplayer.autoplay = true
	audioplayer.set_bus("Background Music")
	add_child(audioplayer)


