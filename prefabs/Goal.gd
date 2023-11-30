extends StaticBody2D

@export var HP = 100

func take_damage(amount):
	HP -= amount
	if HP < 0:
		print("GAME OVER!")
		#TODO imlement game over method
