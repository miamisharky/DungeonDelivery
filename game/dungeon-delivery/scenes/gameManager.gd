extends Node
#Variables
var score := 0
var game_over := false
var time_remaining := 60
var delivery_time_bonus := 5
var combo := 1
#UI
@onready var score_label = $"../UI/ScoreLabel"
@onready var status_label = $"../UI/StatusLabel"
@onready var timer_label = $"../UI/TimerLabel"
@onready var game_timer = $"../GameTimer"
@onready var combo_label = $"../UI/ComboLabel"
#Setup
@onready var main_scene = get_parent()

var package_scene = preload("res://scenes/package/package.tscn")

func _ready():

	update_package_status(false)

	timer_label.text = "Time: " + str(time_remaining)
	combo_label.text = "Combo: x1"

	spawn_package()

	game_timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():

	change_time(-1)

#Credits, combo, time, spawn
func add_score(amount):

	if game_over:
		return

	score += amount * combo
	
	if score % 5 == 0:

		delivery_time_bonus += 1

		print("Difficulty Increased!")

	score_label.text = "Credits: " + str(score)

	print("Credits: ", score)

	spawn_package()

func change_time(amount):

	if game_over:
		return

	time_remaining += amount

	if time_remaining <= 0:
		time_remaining = 0
		timer_label.text = "Time: 0"
		end_game()
		return

	timer_label.text = "Time: " + str(time_remaining)

func add_time(amount):

	change_time(amount)

	if amount > 0:
		print("+" + str(amount) + " Seconds!")

func increase_combo():

	combo += 1

	combo_label.text = "Combo: x" + str(combo)

	print("Combo x" + str(combo))

func end_game():

	if game_over:
		return

	game_over = true

	game_timer.stop()

	timer_label.text = "GAME OVER"

	reset_combo()

	print("Game Over")

func reset_combo():

	combo = 1

	combo_label.text = "Combo: x1"

func update_package_status(is_carrying):

	if is_carrying:
		status_label.text = "Cargo: FULL"
	else:
		status_label.text = "Cargo: EMPTY"

func spawn_package():

	var package = package_scene.instantiate()

	package.position = Vector2(
		randi_range(100, 1000),
		randi_range(100, 600)
	)

	main_scene.call_deferred("add_child", package)
