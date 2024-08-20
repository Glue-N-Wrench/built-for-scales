extends Camera2D

#var cameraZoomOutStep = 0.1//a safe testing value
var cameraZoomOutStep = 0.001
const cameraVerticalSpeed = 150

func _process(delta):
	zoom -= Vector2(cameraZoomOutStep * delta, cameraZoomOutStep * delta)
	position.y -= cameraZoomOutStep * cameraVerticalSpeed * delta
