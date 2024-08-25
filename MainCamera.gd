extends Camera2D

#var cameraZoomOutStep = 0.1 #a safe testing value
var cameraZoomOutStep = 0.002
const cameraVerticalSpeed = 150

# for ingame music
signal gameStarted

func _process(delta):
	if zoom.x > 0.64:
		zoom -= Vector2(cameraZoomOutStep * delta * $"/root/TurnManager".timespeed, cameraZoomOutStep * delta * $"/root/TurnManager".timespeed)
		position.y -= cameraZoomOutStep * cameraVerticalSpeed * delta

func _ready():
	gameStarted.emit()
