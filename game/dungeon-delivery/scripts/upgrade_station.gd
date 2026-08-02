extends Area2D

const ENGINE_COST = 25

@onready var game_manager = $"../GameManager"

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):

	if body.name != "Player":
		return

	var game_manager = $"../GameManager"

	if game_manager.spend_credits(ENGINE_COST):

		if game_manager.equipped_engine == "Starter Engine":

			game_manager.equipped_engine = "Improved Engine"
			print("Unlocked Improved Engine")

		elif game_manager.equipped_engine == "Improved Engine":

			game_manager.equipped_engine = "Industrial Engine"
			print("Unlocked Industrial Engine")

		game_manager.apply_upgrades()

		game_manager.save_game()

		print("Engine upgraded!")
		print("Thrust: " + str(body.thrust_power))

	else:

		print("Need more credits!")
