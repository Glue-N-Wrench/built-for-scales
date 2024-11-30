extends Node

var Buildings:Array[Node2D] = [
	#the index in this array will be the building's ID
	#consider moving this to another global object
	preload("res://Objects/bomb.tscn").instantiate(),
	preload("res://Objects/Houses/Objects/base_house.tscn").instantiate(),
	preload("res://Objects/Houses/Objects/big_house_a.tscn").instantiate(),
	preload("res://Objects/Houses/Objects/big_house_b.tscn").instantiate(),
	preload("res://Objects/Houses/Objects/house_b.tscn").instantiate(),
	preload("res://Objects/Houses/Objects/house_c.tscn").instantiate(),
	preload("res://Objects/Houses/Objects/house_Castle.tscn").instantiate(),
	preload("res://Objects/Houses/Objects/house_Cross.tscn").instantiate(),
	preload("res://Objects/Houses/Objects/house_d.tscn").instantiate(),
	preload("res://Objects/Houses/Objects/house_e.tscn").instantiate(),
	preload("res://Objects/Houses/Objects/house_f.tscn").instantiate(),
	preload("res://Objects/Houses/Objects/house_g.tscn").instantiate(),
	preload("res://Objects/Houses/Objects/house_h.tscn").instantiate(),
	preload("res://Objects/Houses/Objects/house_i.tscn").instantiate(),
	preload("res://Objects/Houses/Objects/house_IShape.tscn").instantiate(),
	preload("res://Objects/Houses/Objects/house_j.tscn").instantiate(),
	preload("res://Objects/Houses/Objects/house_k.tscn").instantiate(),
	preload("res://Objects/Houses/Objects/house_L.tscn").instantiate(),
	preload("res://Objects/Houses/Objects/house_m.tscn").instantiate(),
	preload("res://Objects/Houses/Objects/house_n.tscn").instantiate(),
	preload("res://Objects/Houses/Objects/house_o.tscn").instantiate(),
	preload("res://Objects/Houses/Objects/house_p.tscn").instantiate(),
	preload("res://Objects/Houses/Objects/house_q.tscn").instantiate(),
	preload("res://Objects/Houses/Objects/house_r.tscn").instantiate(),
	preload("res://Objects/Houses/Objects/house_s.tscn").instantiate(),
	preload("res://Objects/Houses/Objects/house_t.tscn").instantiate(),
	preload("res://Objects/Houses/Objects/house_u.tscn").instantiate(),
	preload("res://Objects/Houses/Objects/house_v.tscn").instantiate(),
	preload("res://Objects/Houses/Objects/house_w.tscn").instantiate(),
	preload("res://Objects/Houses/Objects/house_x.tscn").instantiate(),
	preload("res://Objects/Houses/Objects/house_Zshape.tscn").instantiate(),
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
