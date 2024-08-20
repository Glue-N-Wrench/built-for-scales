extends TextureRect

@onready var foghorn_sfx = $"../../foghorn sfx"
var firstTime = true

func _ready():
	TurnManager.updateDay.connect(_on_day_update)

func _on_day_update():
	$Label.text = "Day\n"+str(TurnManager.dayCount)
	foghorn_sfx.play()

func _process(delta):
	$Sun.rotation = -(TurnManager.roundTimer / TurnManager.roundTime) * TAU

func _on_button_pressed():
	if firstTime:
		firstTime = false
		TurnManager.timeButton = $Button
	TurnManager._on_button_toggled($Button.toggled)
