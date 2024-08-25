extends TextureRect

var open = true
const speed = 12
const houseButton = preload("res://UI/house_card.tscn")

func _ready():
	InventoryManager.inventoryUpdated.connect(_on_inventory_update)
	_on_inventory_update()

func _input(event):
	if Input.is_action_just_pressed("building_tray_open"):
		open = !open

func _process(delta):
	if open:
		if position.x>-190:
			position.x -= speed
	else:
		if position.x<125:
			position.x += speed

func _on_tray_button_pressed():
	if open:
		open = false
	else:
		open = true

func _on_inventory_update():
	#removing every child every time is def. the least efficent way to update inventory
	#this can be upgraded
	for child in $ColorRect/BuldingMenu.get_children():
		$ColorRect/BuldingMenu.remove_child(child)
		child.queue_free()
	for itemID in InventoryManager.inventory:
		var newBtn = houseButton.instantiate()
		newBtn.houseNumb = itemID
		newBtn.count = InventoryManager.inventory[itemID]
		$ColorRect/BuldingMenu.add_child(newBtn)
