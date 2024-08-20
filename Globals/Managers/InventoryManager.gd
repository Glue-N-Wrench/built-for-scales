extends Node

var Buildings:Array[HouseInfo] = [
	#the index in this array will be the building's ID
	HouseInfo.new(
		"Bomb", #Name
		"this destroys rocks", #Description
		1, #Chance Higher = more common
		preload("res://assets/bomb.png"), #Picture
		preload("res://Objects/bomb.tscn"), #scene
		3, #Amount
	),
	HouseInfo.new(
		"Alpha House",
		"2x2 house for tiny anchovies",
		2,
		preload("res://assets/Houses/house_2x2_a.png"),
		preload("res://Objects/Houses/Objects/base_house.tscn"),
		2,
	),
	HouseInfo.new(
		"Beta House A",
		"2x2 house for medium chad",
		2,
		preload("res://assets/Houses/house_2x2_b.png"),
		preload("res://Objects/Houses/Objects/house_b.tscn"),
		2,
	),
	HouseInfo.new(
		"3x2 Charley House",
		"3x2 house for big catfish",
		5,
		preload("res://assets/Houses/house_3x2_a.png"),
		preload("res://Objects/Houses/Objects/big_house_a.tscn"),
		1,
	),
	HouseInfo.new(
		"3x2 Delta House", #Name
		"3x2 house for big catfish", #Description
		5, #Chance Higher = more common
		preload("res://assets/Houses/house_3x2_b.png"), #Picture
		preload("res://Objects/Houses/Objects/big_house_b.tscn"), #scene
		1, #Amount
	),
		HouseInfo.new(
		"2x2 Beta House B", #Name
		"2x2 house for medium chad", #Description
		2, #Chance Higher = more common
		preload("res://assets/Houses/house_2x2_b.png"), #Picture
		preload("res://Objects/Houses/Objects/house_b.tscn"), #scene
		2, #Amount
	),
	HouseInfo.new(
		"1x1 Foxtrot House A", #Name
		"1x1 house for tiny anchovies", #Description
		1, #Chance Higher = more common
		preload("res://assets/Houses/house_1x1_a.png"), #Picture
		preload("res://Objects/Houses/Objects/house_c.tscn"), #scene
		2, #Amount
	),
		HouseInfo.new(
		"1x1 Foxtrot House B", #Name
		"1x1 house for tiny anchovies", #Description
		1, #Chance Higher = more common
		preload("res://assets/Houses/house_1x1_b.png"), #Picture
		preload("res://Objects/Houses/Objects/house_d.tscn"), #scene
		2, #Amount
	),
	HouseInfo.new(
		"1x1 Foxtrot House C", #Name
		"1x1 house for tiny anchovies", #Description
		1, #Chance Higher = more common
		preload("res://assets/Houses/house_1x1_c.png"), #Picture
		preload("res://Objects/Houses/Objects/house_e.tscn"), #scene
		2, #Amount
	),
	HouseInfo.new(
		"1x1 Foxtrot House D", #Name
		"1x1 house for tiny anchovies", #Description
		1, #Chance Higher = more common
		preload("res://assets/Houses/house_1x1_d.png"), #Picture
		preload("res://Objects/Houses/Objects/house_f.tscn"), #scene
		2, #Amount
	),
	HouseInfo.new(
		"1x2 Golf House", #Name
		"1x2 house for medium chads", #Description
		2, #Chance Higher = more common
		preload("res://assets/Houses/house_1x2_a.png"), #Picture
		preload("res://Objects/Houses/Objects/house_g.tscn"), #scene
		1, #Amount
	),
	#HouseInfo.new(
		#"", #Name
		#"", #Description
		#1, #Chance Higher = more common
		#preload(), #Picture
		#preload(), #scene
		#1, #Amount
	#),
]

signal inventoryUpdated # a new item, or an item was removed
signal inventoryCountUpdated # a change in count without a change in inventory items
var inventory = {
	#buildingID: count
	0:3,
	1:2,
	2:1,
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
