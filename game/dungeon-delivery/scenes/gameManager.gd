extends Node

var score := 0

@onready var score_label = $"../UI/ScoreLabel"

@onready var main_scene = get_parent()

var package_scene = preload("res://scenes/package/package.tscn")

func _ready():
	spawn_package()

func add_score(amount):
	score += amount

	score_label.text = "Score: " + str(score)

	print("Score: ", score)

	spawn_package()

func spawn_package():

	var package = package_scene.instantiate()

	package.position = Vector2(
		randi_range(100, 1000),
		randi_range(100, 600)
	)

	main_scene.call_deferred("add_child", package)
