extends Node
#Variables
var credits := 0
var engine_level := 0
var best_credits := 0
var game_over := false
var time_remaining := 60
var delivery_time_bonus := 5
var combo := 1
const BASE_THRUST = 450.0
const THRUST_PER_LEVEL = 50.0
#UI
@onready var credits_label = $"../UI/ScoreLabel"
@onready var status_label = $"../UI/StatusLabel"
@onready var timer_label = $"../UI/TimerLabel"
@onready var game_timer = $"../GameTimer"
@onready var combo_label = $"../UI/ComboLabel"
#Setup
@onready var main_scene = get_parent()

var package_scene = preload("res://scenes/package/package.tscn")

func _ready():

	load_game()

	update_package_status(false)

	timer_label.text = "Time: " + str(time_remaining)
	combo_label.text = "Combo: x1"

	spawn_package()

	game_timer.timeout.connect(_on_timer_timeout)

func get_save_data():

	return {
		"credits": credits,
		"engine_level": engine_level,
		"best_credits": best_credits
	}

func save_game():

	var file = FileAccess.open(
		"user://savegame.json",
		FileAccess.WRITE
	)

	file.store_string(
		JSON.stringify(get_save_data())
	)

	print("Game Saved")
	
func load_game():

	if not FileAccess.file_exists(
		"user://savegame.json"
	):
		return

	var file = FileAccess.open(
		"user://savegame.json",
		FileAccess.READ
	)

	var json_text = file.get_as_text()

	var data = JSON.parse_string(json_text)

	if data == null:
		return

	credits = data.get("credits", 0)
	engine_level = data.get("engine_level", 0)
	apply_upgrades()
	best_credits = data.get("best_credits", 0)

	update_credit_display()

	print("Game Loaded")

func _on_timer_timeout():

	change_time(-1)

func get_current_thrust():

	return BASE_THRUST + (
		engine_level * THRUST_PER_LEVEL
	)

func apply_upgrades():

	var player = $"../Player"

	player.thrust_power = get_current_thrust()

	print(
		"Engine Level: " +
		str(engine_level)
	)

	print(
		"Thrust Power: " +
		str(player.thrust_power)
	)


#Credits, combo, time, spawn
func add_score(amount):

	if game_over:
		return

	credits += amount * combo
	update_credit_display()
	
	if credits > best_credits:
		best_credits = credits
	
	if credits % 5 == 0:

		delivery_time_bonus += 1

		print("Difficulty Increased!")

	credits_label.text = "Credits: " + str(credits)

	print("Credits: ", credits)

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
	
func update_credit_display():

	credits_label.text = "Credits: " + str(credits)

func spend_credits(amount):

	if credits < amount:
		return false

	credits -= amount

	update_credit_display()

	return true
