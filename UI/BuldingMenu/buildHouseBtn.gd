extends Button

@export var houseNumb:int = 0

func _on_pressed():
	$"/root/MainLevel/PlacementController".makeSelection(houseNumb)
