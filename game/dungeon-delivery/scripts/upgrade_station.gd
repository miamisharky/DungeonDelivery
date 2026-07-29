extends Area2D

const ENGINE_COST = 25
const ENGINE_UPGRADE = 50

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):

	if body.name != "Player":
		return

	var game_manager = $"../GameManager"

	if game_manager.spend_credits(ENGINE_COST):

		body.thrust_power += ENGINE_UPGRADE

		print("Engine upgraded!")
		print("Thrust: " + str(body.thrust_power))

	else:

		print("Need more credits!")
