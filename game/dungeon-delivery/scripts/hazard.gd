extends Area2D

@export var time_penalty := 10

@onready var game_manager = $"../GameManager"

var can_damage := true

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if not can_damage:
		return

	if body.name == "Player":
		can_damage = false

		game_manager.change_time(-time_penalty)

		print("Hazard hit! -" + str(time_penalty) + " seconds")

		await get_tree().create_timer(1.0).timeout

		can_damage = true
