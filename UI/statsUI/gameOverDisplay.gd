extends HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	TurnManager.updateGameOverTimer.connect(_on_timer_update)

func _on_timer_update():
	if TurnManager.gameOverTimer > 0:
		$warningIcon.visible = true
		self.visible = true
	else:
		$warningIcon.visible = false
		self.visible = false
	$Control/gameOverBar.value = 100-(TurnManager.gameOverTimer / TurnManager.gameOverCount) * 100
