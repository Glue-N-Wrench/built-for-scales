extends Camera2D

@export var speed = 5.0
var cam = self
var cameraZoomOutStep = 0.001

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var directionX = Input.get_axis("camera_left", "camera_right")
	position.x += directionX * speed * delta
	var directionY = Input.get_axis("camera_up", "camera_down")
	position.y += directionY * speed * delta

func _process(delta):
	cam.zoom -= Vector2(cameraZoomOutStep * delta, cameraZoomOutStep * delta)
