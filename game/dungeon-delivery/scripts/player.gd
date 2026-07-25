extends CharacterBody2D

@export var thrust_power := 420.0
@export var boost_multiplier := 2.0
@export var turn_speed := 3.5
@export var max_speed := 650.0
@export var drag := 0.985

var carrying_package := false

func _physics_process(delta):

	var turn_input = Input.get_axis("ui_left", "ui_right")

	rotation += turn_input * turn_speed * delta

	var accelerating = Input.is_action_pressed("ui_up")
	var boosting = Input.is_action_pressed("ui_accept")
	var braking = Input.is_action_pressed("ui_down")

	var thrust = thrust_power

	if boosting:
		thrust *= boost_multiplier

	if accelerating:
		var forward = Vector2.RIGHT.rotated(rotation)
		velocity += forward * thrust * delta

	if braking:
		velocity *= 0.96

	velocity *= pow(drag, delta * 60.0)

	velocity = velocity.limit_length(max_speed)

	move_and_slide()
