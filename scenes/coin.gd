extends Area2D

@onready var game_manager = $/root/Main/GameManager


func _on_body_entered(body):
	if (body.name == "Dino"):
		queue_free()
		if game_manager:
			game_manager.add_coin()
	if body.name != "Dino":
		queue_free()
