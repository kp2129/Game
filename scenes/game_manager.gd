extends Node

# Assuming CoinsLabel is a Label node


var points = UserManager.instance.coins

func add_point():  
	points += 1
	print("Points:", points)
	
