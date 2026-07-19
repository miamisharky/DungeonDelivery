extends Area2D

@onready var game_manager = $"../GameManager"

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):

	if body.name == "Player":

		body.carrying_package = true

		game_manager.update_package_status(true)

		queue_free()
