extends Node

# Singleton instance
static var instance

# Token variable
var user_token = ""
var user_id = ""
var username = ""

func _ready():
	# Assign the singleton instance
	instance = self
