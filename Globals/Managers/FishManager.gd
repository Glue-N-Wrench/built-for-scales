extends Node

static var fishRNG = RandomNumberGenerator.new()

signal fishUpdated #should be signaled when homelessFish gets changed
# ^ handles the fish/building allocation

@onready var fishObjects = {
	0: preload("res://Objects/Fish/fish.tscn"),
	1: preload("res://Objects/Fish/fish_scad.tscn"),
	2: preload("res://Objects/Fish/fish_catfish.tscn"),
}

var homelessFish:Dictionary = {
	0:[],
	1:[],
	2:[],
} #dict of homeless fish nodes sorted by type
var activeHouses:Array = [] #all the houses that get run when fish need to be changed
const maxHomeless = 10

const fixedFishWaves = [
		[0,0,0],	# 3 anchovies
		[0,0,0,1],	# 3 anchovies 1 scad
		[0,0,1,1],	# 2 anchovies 2 scad
		[0,0,0,0,0],# 5 anchovies
	]


func reset():
	#reset globals to their starting values
	activeHouses = []
	homelessFish = {
		0:[],
		1:[],
		2:[],
	}
	for child in get_children():
		child.queue_free()

func _ready():
	fishRNG.randomize()

func getTotalHomeless():
		var sum = 0
		for size in homelessFish:
			sum += homelessFish[size].size()
		return sum

var previousWavehasCatfish = false
func makeNewFishBatch(points:int):
	#TODO: make this more intresting
	var currentWaveHasCatfish = false
	if (TurnManager.dayCount-1) < fixedFishWaves.size():
		for fishID in fixedFishWaves[TurnManager.dayCount-1]:
			spawnFish(fishID)
	else:
		while points>0:
			var purchase = fishRNG.randi_range(1,min(points, 3))
			if purchase == 3:
				if previousWavehasCatfish:
					purchase = 2
				else:
					currentWaveHasCatfish = true
			spawnFish(purchase-1)
			points -= purchase
	currentWaveHasCatfish
	CheckHouses()

func spawnFish(type:int):
	#create a new homeless fish of [type] off screen
	var newFish = fishObjects[type].instantiate()
	var direction = fishRNG.randi_range(0,1)
	var offset = randf_range(-400,300)
	match direction:
		0:
			newFish.position = Vector2(ViewManager.gridLimitSides*2, offset)
		1:
			newFish.position = Vector2(-ViewManager.gridLimitSides*2, offset)
	newFish.go_to_location(Vector2(0,0))
	add_child(newFish)
	homelessFish[type].push_front(newFish)
	fishUpdated.emit()

func addHouse(house:House):
	activeHouses.append(house)

	CheckHouses()

func removeHouse(house:House):
	activeHouses.erase(house)
	for size in house.current_fish:
		for fish in house.current_fish[size]:
			fish.go_to_location(house.position)
			fish.homeless=true
		homelessFish[size].append_array(house.current_fish[size])
	fishUpdated.emit()	
	CheckHouses()


func CheckHouses():
	#when a house is built or destroyed, or new fish are created
	var startingHomelessFish = homelessFish.duplicate(true)
	var fish_left = 0 #fish left to allocate
	for size in homelessFish:
		fish_left += homelessFish[size].size()
	for house:House in activeHouses:
		#free rooms 
		house.hasFish = false
		for size in house.current_fish:
			homelessFish[size].append_array(house.current_fish[size])
			fish_left += house.current_fish[size].size()
			house.current_fish[size] = []
			for fish:Fish in house.current_fish[size]:
				fish.become_homeless()
		var free_rooms = house.fish_capacity
		# put best fish in each room
		for i in range(house.max_fish_size,-1,-1):#count down from biggest in house to smallest
			if homelessFish[i].size() < free_rooms:
				#put all homeless fish of this size in this house
				free_rooms -= homelessFish[i].size()
				fish_left -= homelessFish[i].size()
				for fish:Fish in homelessFish[i]:
					fish.go_to_house(house)
				house.current_fish[i] = homelessFish[i]
				homelessFish[i] = []
				continue #next fish size
			else:
				#fill the house with homeless fish of this size
				#free_rooms = 0 #step implied for symmetry, but isn't nessasry b/c of the break
				fish_left -= free_rooms
				var movedObjects = homelessFish[i].slice(-free_rooms)
				for fish:Fish in movedObjects:
					fish.go_to_house(house)
				#move [free_rooms] items from homelessfish to house
				homelessFish[i] = homelessFish[i].slice(0,-free_rooms)
				house.current_fish[i] = movedObjects
				break #next house
		if fish_left <= 0: #less than 0 shouldn't be possible but I dont want to get stuck
			break # no fish left - done with houses
	#go again if needed
	CheckVancy()
	if (startingHomelessFish != homelessFish):
		fishUpdated.emit()
		CheckVancy()
		if fish_left > 0:
			CheckVancy()
			CheckHouses() #if there was any change AND there are fish left - recurse


func CheckVancy():
	var size1VacancyLabel: Label = $"../MainLevel/Camera2D/MainUI/HomelessFishContainer/HomelessFish/FishNumbers2/size1Vacancies"
	var size2VacancyLabel: Label = $'../MainLevel/Camera2D/MainUI/HomelessFishContainer/HomelessFish/FishNumbers2/size2Vacancies'
	var size3VacancyLabel: Label = $'../MainLevel/Camera2D/MainUI/HomelessFishContainer/HomelessFish/FishNumbers2/size3Vacancies'
	var size1Vacancies = 0
	var size2Vacancies = 0
	var size3Vacancies = 0

	#this is built to display the amount of extra spaces a player has at a given time, 
	#so if a player has an emptu house that can hold two medium fish 
	#it updates the Vacany UI of medium fish by adding 2 to it
	for selectedHouse:House in activeHouses:
		var totalFishInHouse = 0
		for size in selectedHouse.current_fish:
			totalFishInHouse += selectedHouse.current_fish[size].size()
		print("DEBUGVCNCY: totalFishInSelectedHouse = {" + str(totalFishInHouse) + "}"  )
		match (selectedHouse.max_fish_size):
			0:
				size1Vacancies += selectedHouse.fish_capacity - totalFishInHouse
				print("DEBUGVCNCY: size0housecap: {" + str(selectedHouse.fish_capacity) + "}")
				size1VacancyLabel.text = str(size1Vacancies)
			1:
				size2Vacancies += selectedHouse.fish_capacity - totalFishInHouse
				print("DEBUGVCNCY: size1housecap: {" + str(selectedHouse.fish_capacity) + "}")
				size2VacancyLabel.text = str(size2Vacancies)
			2:
				size3Vacancies += selectedHouse.fish_capacity - totalFishInHouse
				print("DEBUGVCNCY: size2housecap: {" + str(selectedHouse.fish_capacity) + "}")
				size3VacancyLabel.text = str(size3Vacancies)
