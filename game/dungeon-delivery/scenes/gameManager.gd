extends Node

var score := 0
var game_over := false
var time_remaining := 60
var delivery_time_bonus := 5

@onready var score_label = $"../UI/ScoreLabel"

@onready var status_label = $"../UI/StatusLabel"

@onready var timer_label = $"../UI/TimerLabel"
@onready var game_timer = $"../GameTimer"

@onready var main_scene = get_parent()

var package_scene = preload("res://scenes/package/package.tscn")

func _ready():

	update_package_status(false)

	timer_label.text = "Time: " + str(time_remaining)

	spawn_package()

	game_timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():

	time_remaining -= 1

	timer_label.text = "Time: " + str(time_remaining)

	if time_remaining <= 0:

		game_over = true

		game_timer.stop()

		timer_label.text = "GAME OVER"

		print("Game Over")

func add_score(amount):

	if game_over:
		return

	score += amount
	
	if score % 5 == 0:

		delivery_time_bonus += 1

		print("Difficulty Increased!")

	score_label.text = "Score: " + str(score)

	print("Score: ", score)

	spawn_package()

func add_time(amount):

	if game_over:
		return

	time_remaining += amount

	timer_label.text = "Time: " + str(time_remaining)
	
	print("+" + str(amount) + " Seconds!")

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
