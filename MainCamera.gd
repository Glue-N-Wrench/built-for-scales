extends Camera2D

@export var speed = 5.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var directionX = Input.get_axis("camera_left", "camera_right")
	position.x += directionX * speed
	var directionY = Input.get_axis("camera_up", "camera_down")
	position.y += directionY * speed
