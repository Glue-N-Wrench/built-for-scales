@tool
extends VBoxContainer
var houseNumb:int = 0
var count:int = 1

func _on_texture_button_pressed():
	$"/root/MainLevel/PlacementController".makeSelection(houseNumb)

func _ready():
	var target_house_sprite = InventoryManager.Buildings[houseNumb].texture
	if target_house_sprite:
		$TextureButton.texture_normal = target_house_sprite
	$nameLabel.text = InventoryManager.Buildings[houseNumb].name
	$countLabel.text = str(InventoryManager.inventory[houseNumb])
