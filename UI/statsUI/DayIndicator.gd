extends TextureRect

func _process(delta):
	$Sun.rotation = (TurnManager.roundTimer / TurnManager.roundTime) * TAU
