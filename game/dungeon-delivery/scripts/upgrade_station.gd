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

		game_manager.engine_level += 1
		game_manager.apply_upgrades()

		game_manager.save_game()

		print("Engine upgraded!")
		print("Thrust: " + str(body.thrust_power))

	else:

		print("Need more credits!")
