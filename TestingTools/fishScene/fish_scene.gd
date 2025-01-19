extends Node2D

func _ready():
	for fish in FishManager.fishObjects:
		FishManager.spawnFish(fish)

func addFish(type):
	FishManager.spawnFish(type)

func addHouse(type):
	var house = 0
	if type == 0:
		house = 1
	if type == 1:
		house = 4
	if type == 2:
		house = 2
	var selectedObject = BuildingData.Buildings[house].duplicate()
	add_child(selectedObject)
	FishManager.addHouse(selectedObject)
