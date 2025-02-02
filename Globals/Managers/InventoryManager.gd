extends Node

signal inventoryUpdated # a new item, or an item was removed
signal inventoryCountUpdated # a change in count without a change in inventory items
var inventory = {
	#buildingID: count
	0:3,
	#20:2,
	31:2,
	32:3,
	#5:1,
}

func reset():
	#reset globals to their starting values
	inventory = {
	0:3,
	20:2,
	31:2,
	32:2,
	5:1,
	}

func addItems(key, amount):
	if key in inventory:
		inventory[key] += amount
		inventoryCountUpdated.emit()
	else:
		inventory[key] = amount
		inventoryUpdated.emit()

func decrementItem(key):
	inventory[key] -= 1
	if inventory[key] == 0:
		inventory.erase(key)
		inventoryUpdated.emit()
	else:
		inventoryCountUpdated.emit()
