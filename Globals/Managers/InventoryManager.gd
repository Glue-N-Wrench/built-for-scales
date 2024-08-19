extends Node

var Buildings:Array[HouseInfo] = [
	#the index in this array will be the building's ID
	#HouseInfo.new(
		#"Bomb",
		#"this destroys rocks"
		#3,
		#preload(),
		#preload("res://Objects/Houses/base_house.tscn"),
	#),
	HouseInfo.new(
		"Alpha House",
		"2x2 house for tiny anchovies",
		1,
		preload("res://Objects/Houses/Textures/house_2x2_a.png"),
		preload("res://Objects/Houses/base_house.tscn"),
	),
	HouseInfo.new(
		"Beta House",
		"2x2 house for medium chad",
		1,
		preload("res://Objects/Houses/Textures/house_2x2_b.png"),
		preload("res://Objects/Houses/house_b.tscn"),
	),
	HouseInfo.new(
		"3x2 Charley House",
		"3x2 house for big catfish",
		1,
		preload("res://Objects/Houses/Textures/house_3x2_a.png"),
		preload("res://Objects/Houses/big_house_a.tscn"),
	),
]

signal inventoryUpdated
var inventory = {
	#buildingID: count
	0:3,
	1:2,
	2:1,
}
