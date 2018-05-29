extends Area2D

export (int) var SPEED
export (float) var ROTATION_DEG_PER_FRAME
export (int) var ROTATION_TOLERANCE
export (int) var ACC_LIMIT

var rotation_locked = false
var acc_mode = false

func _process(delta):
	var velocity = Vector2()
	if acc_mode:
		velocity = get_acc_velocity()
	else:
		velocity = get_kb_velocity()

	# Only rotate towards direction of movement if velocity is fast.
	if abs(velocity.x) > ACC_LIMIT / 3 || abs(velocity.y) > ACC_LIMIT / 3:
		var desired_look_dir = rad2deg(velocity.rotated(deg2rad(90)).angle())
		var look_dir_diff = fmod(round(rotation_degrees - desired_look_dir + 360), 360.0)

		# Close enough to looking towards desired look direction, so stop rotation.
		if abs(look_dir_diff) > ROTATION_TOLERANCE:
			rotation_locked = false
			if look_dir_diff > 180:
				rotation_degrees += ROTATION_DEG_PER_FRAME
			else:
				rotation_degrees -= ROTATION_DEG_PER_FRAME
		else:
			if not(rotation_locked):
				rotation_degrees = desired_look_dir
				rotation_locked = true

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
