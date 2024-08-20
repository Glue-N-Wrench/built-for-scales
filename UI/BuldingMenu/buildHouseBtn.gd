@tool
extends Button
var houseNumb:int = 0
var count:int = 1

func _on_inventory_count_updated():
	$countLabel.text = str(InventoryManager.inventory[houseNumb])

func _on_pressed():
	$"/root/MainLevel/PlacementController".makeSelection(houseNumb)

func _ready():
	InventoryManager.inventoryCountUpdated.connect(_on_inventory_count_updated)
	var target_house_sprite = InventoryManager.Buildings[houseNumb].texture
	if target_house_sprite:
		$TextureButton.texture = target_house_sprite
	$nameLabel.text = InventoryManager.Buildings[houseNumb].name
	$countLabel.text = str(InventoryManager.inventory[houseNumb])
