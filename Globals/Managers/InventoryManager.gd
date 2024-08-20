extends Node

var Buildings:Array[HouseInfo] = [
	#the index in this array will be the building's ID
	HouseInfo.new( #0
		"Bomb", #Name
		"this destroys rocks and houses", #Description
		25, #Chance Higher = more common
		preload("res://assets/bomb.png"), #Picture
		preload("res://Objects/bomb.tscn"), #scene
		3, #Amount
	),
	HouseInfo.new( #1
		"Alpha House A",
		"2x2 house for tiny anchovies",
		3,
		preload("res://assets/Houses/house_2x2_a.png"),
		preload("res://Objects/Houses/Objects/base_house.tscn"),
		2,
	),
	HouseInfo.new( #2
		"Beta House A",
		"2x2 house for medium scads",
		4,
		preload("res://assets/Houses/house_2x2_b.png"),
		preload("res://Objects/Houses/Objects/house_b.tscn"),
		2,
	),
	HouseInfo.new( #3
		"Charley House",
		"3x2 house for big catfish",
		10,
		preload("res://assets/Houses/house_3x2_a.png"),
		preload("res://Objects/Houses/Objects/big_house_a.tscn"),
		1,
	),
	HouseInfo.new( #4
		"Delta House", #Name
		"3x2 house for big catfish", #Description
		10, #Chance Higher = more common
		preload("res://assets/Houses/house_3x2_b.png"), #Picture
		preload("res://Objects/Houses/Objects/big_house_b.tscn"), #scene
		1, #Amount
	),
		HouseInfo.new( #5
		"Beta House B", #Name
		"2x2 house for medium scads", #Description
		4, #Chance Higher = more common
		preload("res://assets/Houses/house_2x2_b.png"), #Picture
		preload("res://Objects/Houses/Objects/house_b.tscn"), #scene
		2, #Amount
	),
	HouseInfo.new(
		"Foxtrot House A", #Name
		"1x1 house for tiny anchovies", #Description
		3, #Chance Higher = more common
		preload("res://assets/Houses/house_1x1_a.png"), #Picture
		preload("res://Objects/Houses/Objects/house_c.tscn"), #scene
		2, #Amount
	),
		HouseInfo.new(
		"Foxtrot House B", #Name
		"1x1 house for tiny anchovies", #Description
		3, #Chance Higher = more common
		preload("res://assets/Houses/house_1x1_b.png"), #Picture
		preload("res://Objects/Houses/Objects/house_d.tscn"), #scene
		2, #Amount
	),
	HouseInfo.new(
		"Foxtrot House C", #Name
		"1x1 house for tiny anchovies", #Description
		3, #Chance Higher = more common
		preload("res://assets/Houses/house_1x1_c.png"), #Picture
		preload("res://Objects/Houses/Objects/house_e.tscn"), #scene
		2, #Amount
	),
	HouseInfo.new(
		"Foxtrot House D", #Name
		"1x1 house for tiny anchovies", #Description
		3, #Chance Higher = more common
		preload("res://assets/Houses/house_1x1_d.png"), #Picture
		preload("res://Objects/Houses/Objects/house_f.tscn"), #scene
		2, #Amount
	),
	HouseInfo.new( #10
		"Golf House A", #Name
		"1x2 house for medium scads", #Description
		4, #Chance Higher = more common
		preload("res://assets/Houses/house_1x2_a.png"), #Picture
		preload("res://Objects/Houses/Objects/house_g.tscn"), #scene
		2, #Amount
	),
		HouseInfo.new(
		"Golf House B", #Name
		"1x2 house for tiny anchovies", #Description
		2, #Chance Higher = more common
		preload("res://assets/Houses/house_1x2_b.png"), #Picture
		preload("res://Objects/Houses/Objects/house_h.tscn"), #scene
		2, #Amount
	),
	HouseInfo.new(
		"Hotel House A", #Name
		"1x3 house for tiny anchovies", #Description
		2, #Chance Higher = more common
		preload("res://assets/Houses/house_1x3_a.png"), #Picture
		preload("res://Objects/Houses/Objects/house_i.tscn"), #scene
		2, #Amount
	),
	HouseInfo.new(
		"Hotel House B", #Name
		"1x3 house for medium scads", #Description
		4, #Chance Higher = more common
		preload("res://assets/Houses/house_1x3_b.png"), #Picture
		preload("res://Objects/Houses/Objects/house_j.tscn"), #scene
		2, #Amount
	),
	HouseInfo.new(
		"India House A", #Name
		"2x1 house for tiny anchovies", #Description
		2, #Chance Higher = more common
		preload("res://assets/Houses/house_2x1_a.png"), #Picture
		preload("res://Objects/Houses/Objects/house_k.tscn"), #scene
		2, #Amount
	),
	HouseInfo.new( #15
		"India House B", #Name
		"2x1 house for medium scads", #Description
		4, #Chance Higher = more common
		preload("res://assets/Houses/house_2x1_b.png"), #Picture
		preload("res://Objects/Houses/Objects/house_L.tscn"), #scene
		2, #Amount
	),
		HouseInfo.new(
		"Beta House C", #Name
		"2x2 house for medium scads", #Description
		4, #Chance Higher = more common
		preload("res://assets/Houses/house_2x2_b.png"), #Picture
		preload("res://Objects/Houses/Objects/house_m.tscn"), #scene
		1, #Amount
	),
	HouseInfo.new(
		"Alpha House B", #Name
		"2x2 house for tiny anchovies", #Description
		2, #Chance Higher = more common
		preload("res://assets/Houses/house_2x2_c.png"), #Picture
		preload("res://Objects/Houses/Objects/house_n.tscn"), #scene
		2, #Amount
	),
		HouseInfo.new(
		"Juliett House A", #Name
		"1 + 2x1 house for medium scads", #Description
		4, #Chance Higher = more common
		preload("res://assets/Houses/house_2x2_DL_a.png"), #Picture
		preload("res://Objects/Houses/Objects/house_o.tscn"), #scene
		3, #Amount
	),
	HouseInfo.new(
		"Juliett House B", #Name
		"1 + 2x1 house for tiny anchovies", #Description
		4, #Chance Higher = more common
		preload("res://assets/Houses/house_2x2_DR_a.png"), #Picture
		preload("res://Objects/Houses/Objects/house_p.tscn"), #scene
		4, #Amount
	),
	HouseInfo.new( #20
		"Kilo House A", #Name
		"2x1 + 1 house for tiny anchovies", #Description
		2, #Chance Higher = more common
		preload("res://assets/Houses/house_2x2_UL_a.png"), #Picture
		preload("res://Objects/Houses/Objects/house_q.tscn"), #scene
		3, #Amount
	),
	HouseInfo.new(
		"Lima House A", #Name
		"3x1 house for tiny anchovies", #Description
		3, #Chance Higher = more common
		preload("res://assets/Houses/house_3x1_a.png"), #Picture
		preload("res://Objects/Houses/Objects/house_r.tscn"), #scene
		2, #Amount
	),
	HouseInfo.new(
		"Lima House B", #Name
		"3x1 house for tiny anchovies", #Description
		3, #Chance Higher = more common
		preload("res://assets/Houses/house_3x1_b.png"), #Picture
		preload("res://Objects/Houses/Objects/house_s.tscn"), #scene
		2, #Amount
	),
	HouseInfo.new(
		"Mike House", #Name
		"3x1 + 1 house for medium scads", #Description
		5, #Chance Higher = more common
		preload("res://assets/Houses/house_2x3T_a.png"), #Picture
		preload("res://Objects/Houses/Objects/house_t.tscn"), #scene
		4, #Amount
	),
	HouseInfo.new(
		"November House", #Name
		"2x1 + 1x3 house for tiny anchovies", #Description
		4, #Chance Higher = more common
		preload("res://assets/Houses/house_2x4_UL_a.png"), #Picture
		preload("res://Objects/Houses/Objects/house_u.tscn"), #scene
		3, #Amount
	),
	HouseInfo.new(
		"Oscar House", #Name
		"1x2 + 2x1 house for medium scad", #Description
		4, #Chance Higher = more common
		preload("res://assets/Houses/house_3x2_DL_a.png"), #Picture
		preload("res://Objects/Houses/Objects/house_v.tscn"), #scene
		3, #Amount
	),
	HouseInfo.new(
		"Papa House", #Name
		"3x2 + 1 house for big catfish", #Description
		5, #Chance Higher = more common
		preload("res://assets/Houses/house_3x3_a.png"), #Picture
		preload("res://Objects/Houses/Objects/house_w.tscn"), #scene
		1, #Amount
	),
	HouseInfo.new(
		"Quebec House", #Name
		"2x3 C shaped house for tiny anchovies", #Description
		2, #Chance Higher = more common
		preload("res://assets/Houses/house_3x2_c_a.png"), #Picture
		preload("res://Objects/Houses/Objects/house_x.tscn"), #scene
		3, #Amount
	)
]

signal inventoryUpdated # a new item, or an item was removed
signal inventoryCountUpdated # a change in count without a change in inventory items
var inventory = {
	#buildingID: count
	0:3,
	20:2,
	5:1,
}

func reset():
	#reset globals to their starting values
	inventory = {
	0:3,
	20:2,
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
