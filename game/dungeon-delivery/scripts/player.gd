
extends CharacterBody2D

@export var move_speed := 300.0

var carrying_package := false

func _physics_process(delta):
	var direction = Input.get_vector(
		"ui_left",
		"ui_right",
		"ui_up",
        "ui_down"
	)

	velocity = direction * move_speed
	move_and_slide()
