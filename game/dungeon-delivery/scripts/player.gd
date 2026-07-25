extends CharacterBody2D

@export var thrust_power := 450.0
@export var turn_speed := 3.0
@export var boost_multiplier := 2.0
@export var max_speed := 700.0
@export var drag := 0.99

var carrying_package := false

func _physics_process(delta):

	var turn_input = Input.get_axis("ui_left", "ui_right")

	rotation += turn_input * turn_speed * delta

	var thrust = thrust_power

	if Input.is_action_pressed("ui_accept"):
		thrust *= boost_multiplier

	if Input.is_action_pressed("ui_up"):

		var forward = Vector2.RIGHT.rotated(rotation)

		velocity += forward * thrust * delta

	if Input.is_action_pressed("ui_down"):
		velocity *= 0.97

	velocity *= drag

	velocity = velocity.limit_length(max_speed)

	move_and_slide()
