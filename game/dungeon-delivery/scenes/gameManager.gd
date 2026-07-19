extends Node

var score := 0

@onready var score_label = $"../UI/ScoreLabel"

@onready var status_label = $"../UI/StatusLabel"

@onready var main_scene = get_parent()

var package_scene = preload("res://scenes/package/package.tscn")

func _ready():

	update_package_status(false)

	spawn_package()

func add_score(amount):
	score += amount

	score_label.text = "Score: " + str(score)

	print("Score: ", score)

	spawn_package()

func update_package_status(is_carrying):

	if is_carrying:
		status_label.text = "Package: YES"
	else:
		status_label.text = "Package: NO"

func spawn_package():

	var package = package_scene.instantiate()

	package.position = Vector2(
		randi_range(100, 1000),
		randi_range(100, 600)
	)

	main_scene.call_deferred("add_child", package)
