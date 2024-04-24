extends Node

# Singleton instance
static var instance

# Token variable
var user_token = ""

func _ready():
	# Assign the singleton instance
	instance = self
