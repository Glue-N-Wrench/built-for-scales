extends TextureRect
@onready var new_day_sfx = $"../../new day sfx"

func _ready():
	TurnManager.updateDay.connect(_on_day_update)

func _on_day_update():
	$Label.text = "Day\n"+str(TurnManager.dayCount)
	new_day_sfx.play()

func _process(delta):
	$Sun.rotation = -(TurnManager.roundTimer / TurnManager.roundTime) * TAU
