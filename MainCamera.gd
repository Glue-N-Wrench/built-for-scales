extends Camera2D

#var cameraZoomOutStep = 0.1 #a safe testing value
const cameraZoomOutStep = 0.00085
const cameraVerticalSpeed = 0.3

# for ingame music
signal gameStarted

func _process(delta):
	if zoom.x > 0.64:
		var cameraChange = (cameraZoomOutStep * delta * $"/root/TurnManager".timespeed)
		#old method:
		#zoom -= Vector2(cameraChange, cameraChange)
		#new method - constant increase by pixel; this works because zoom = 1/scale:
		zoom = zoom/(1+cameraChange)
		position.y -= cameraVerticalSpeed * delta * $"/root/TurnManager".timespeed

func _ready():
	gameStarted.emit()
