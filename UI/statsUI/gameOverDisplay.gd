extends HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	TurnManager.updateGameOverTimer.connect(_on_timer_update)

func _on_timer_update():
	if TurnManager.gameOverTimer > 0:
		$warningIcon.visible = true
	else:
		$warningIcon.visible = false
	$Control/gameOverBar.value = (TurnManager.gameOverTimer / TurnManager.gameOverCount) * 100
	
