extends Button

@export var houseNumb:int = 0

func _on_pressed():
	$"../../PlacementController".makeSelection(houseNumb)
