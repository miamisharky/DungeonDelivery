extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):

	if body.name == "Player":

		if body.carrying_package:

			body.carrying_package = false

			print("Delivery Complete!")
