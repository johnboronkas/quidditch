extends Area2D

export (int) var SPEED
export (int) var ACC_LIMIT

func _ready():
	pass

func _process(delta):
	var x_tilt = clamp(Input.get_accelerometer().x, -ACC_LIMIT, ACC_LIMIT)
	var y_tilt = clamp(-Input.get_accelerometer().y, -ACC_LIMIT, ACC_LIMIT)
	var velocity = Vector2(x_tilt, y_tilt)
	position += velocity * SPEED * delta
