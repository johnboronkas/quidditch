extends Area2D

export (int) var SPEED
export (float) var ROTATION_SPEED
export (int) var ACC_LIMIT

func _process(delta):
	var x_tilt = clamp(Input.get_accelerometer().x, -ACC_LIMIT, ACC_LIMIT)
	var y_tilt = clamp(-Input.get_accelerometer().y, -ACC_LIMIT, ACC_LIMIT)
	var velocity = Vector2(x_tilt, y_tilt)

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
