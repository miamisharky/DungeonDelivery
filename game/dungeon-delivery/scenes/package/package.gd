extends Area2D

@export var credit_value := 1
@export var salvage_type := "Scrap Metal"

@onready var game_manager = $"../GameManager"

func _ready():

	body_entered.connect(_on_body_entered)

	randomize_salvage()

func randomize_salvage():

	var roll = randi_range(1,100)

	if roll <= 70:

		salvage_type = "Scrap Metal"
		credit_value = 1

		$Sprite2D.modulate = Color.GRAY

	elif roll <= 95:

		salvage_type = "Broken Satellite"
		credit_value = 3

		$Sprite2D.modulate = Color.CORNFLOWER_BLUE

	else:

		salvage_type = "Alien Artifact"
		credit_value = 10

		$Sprite2D.modulate = Color.MEDIUM_PURPLE

func _on_body_entered(body):

	if body.name == "Player":

		body.carrying_package = true

		body.cargo_value = credit_value
		body.cargo_type = salvage_type
		
		print(
			"Collected: " +
			salvage_type +
	 		" Value: " +
			str(credit_value)
		)

		game_manager.update_package_status(true)

		queue_free()
