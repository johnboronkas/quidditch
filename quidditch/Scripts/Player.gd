extends Area2D

export (int) var SPEED
export (int) var ACC_LIMIT

var look_dir_lerp_value
var last_look_dir

func _ready():
	look_dir_lerp_value = 0
	last_look_dir = 0

func _process(delta):
	var x_tilt = clamp(Input.get_accelerometer().x, -ACC_LIMIT, ACC_LIMIT)
	var y_tilt = clamp(-Input.get_accelerometer().y, -ACC_LIMIT, ACC_LIMIT)
	var velocity = Vector2(x_tilt, y_tilt)

	var look_dir = position.angle_to(-velocity)
	if last_look_dir != look_dir:
		look_dir_lerp_value = 0
	last_look_dir = look_dir
	rotation = lerp(last_look_dir, look_dir, look_dir_lerp_value)
	look_dir_lerp_value += 0.2
	if look_dir_lerp_value > 1:
		look_dir_lerp_value = 1

	position += velocity * SPEED * delta
