extends Node

var coins = UserManager.instance.coins


func add_coin():
	coins += 1


var points = 0

func add_point():  
	points += 1
	print("Points:", points)
	

