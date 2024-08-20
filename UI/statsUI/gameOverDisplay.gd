extends HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	TurnManager.updateGameOverTimer.connect(_on_timer_update)

func _on_timer_update():
	if TurnManager.gameOverTimer < TurnManager.gameOverCount:
		$warningIcon.visible = true
		self.visible = true
	else:
		$warningIcon.visible = false
		self.visible = false
	$Control/gameOverBar.value = (TurnManager.gameOverTimer / TurnManager.gameOverCount) * 100
