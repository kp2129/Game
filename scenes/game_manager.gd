extends Node

var coins = 0


func add_coin():
	coins += 1


var points = UserManager.instance.coins

func add_point():  
	points += 1
	print("Points:", points)
	

