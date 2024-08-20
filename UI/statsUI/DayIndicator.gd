extends TextureRect

@onready var foghorn_sfx = $"../../foghorn sfx"

func _ready():
	TurnManager.updateDay.connect(_on_day_update)
	$Button.toggled.connect(TurnManager._on_button_toggled)

func _on_day_update():
	$Label.text = "Day\n"+str(TurnManager.dayCount)
	foghorn_sfx.play()

func _process(delta):
	$Sun.rotation = -(TurnManager.roundTimer / TurnManager.roundTime) * TAU



