extends Area2D

export (int) var SPEED
export (float) var ROTATION_SPEED
export (int) var ACC_LIMIT

var acc_mode = false

func _process(delta):
	var velocity = Vector2()
	if acc_mode:
		velocity = get_acc_velocity()
	else:
		velocity = get_kb_velocity()

	# Only rotate towards direction of movement if velocity is fast.
	if abs(velocity.x) > 1 || abs(velocity.y) > 1:
		var desired_look_dir = position.angle_to(-velocity)
		var look_dir_diff = rotation_degrees - desired_look_dir

		# Close enough to looking towards desired look direction, so stop rotation.
		if abs(look_dir_diff) > 2:
			if look_dir_diff < 0:
				rotation_degrees += ROTATION_SPEED
			else:
				rotation_degrees -= ROTATION_SPEED

	position += velocity * SPEED * delta

func get_acc_velocity():
	var x_tilt = clamp(Input.get_accelerometer().x, -ACC_LIMIT, ACC_LIMIT)
	var y_tilt = clamp(-Input.get_accelerometer().y, -ACC_LIMIT, ACC_LIMIT)
	return Vector2(x_tilt, y_tilt)

func get_kb_velocity():
	var velocity = Vector2()

	if Input.is_action_pressed("ui_right"):
		velocity.x += ACC_LIMIT
	if Input.is_action_pressed("ui_left"):
		velocity.x -= ACC_LIMIT
	if Input.is_action_pressed("ui_down"):
		velocity.y += ACC_LIMIT
	if Input.is_action_pressed("ui_up"):
		velocity.y -= ACC_LIMIT

	return velocity
