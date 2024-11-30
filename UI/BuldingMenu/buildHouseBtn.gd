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
	var building_node = InventoryManager.Buildings[houseNumb]
	$nameLabel.text = building_node.displayName
	$countLabel.text = str(InventoryManager.inventory[houseNumb])
	var building_sprite = building_node.get_node_or_null("Sprite2D") as Sprite2D
	if building_sprite:
		$TextureButton.texture = building_sprite.texture
