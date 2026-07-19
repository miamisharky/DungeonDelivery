extends Area2D

@onready var game_manager = $"../GameManager"

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):

	if body.name == "Player":

		if body.carrying_package:

			body.carrying_package = false
			
			game_manager.update_package_status(false)

			game_manager.add_score(1)

			print("Delivery Complete!")
