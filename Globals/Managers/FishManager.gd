extends Node

signal fishUpdated #should be signaled when homelessFish gets changed

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

const maxHomeless = 5

func makeNewFishBatch(points:int):
	#TODO: make this more intresting
	for i in points:
		spawnFish(0)
	fishUpdated.emit()
	CheckHouses()

func spawnFish(type:int):
	#create a new homeless fish of [type] off screen
	var newFish = fishObjects[type].instantiate()
	var direction = randi_range(0,1)
	var offset = randf_range(-500,500)
	match direction:
		0:
			newFish.position = Vector2(800, offset)
		1:
			newFish.position = Vector2(-800, offset)
	newFish.go_to_location(Vector2(0,0))
	add_child(newFish)
	homelessFish[type].push_front(newFish)

func addHouse(house:Node2D):
	activeHouses.append(house)
	CheckHouses()

func CheckHouses():
	#when a house is built or destroyed, or new fish are created
	var startingHomelessFish = homelessFish.duplicate(true)
	var fish_left = 0 #fish left to allocate
	for size in homelessFish:
		fish_left += homelessFish[size].size()
	for house:House in activeHouses:
		#free rooms 
		for size in house.current_fish:
			homelessFish[size].append_array(house.current_fish[size])
			fish_left += house.current_fish[size].size()
			house.current_fish[size] = []
			for fish:Fish in house.current_fish[size]:
				fish.homeless=true
		var free_rooms = house.fish_capacity
		# put best fish in each room
		for i in range(house.max_fish_size,-1,-1):#count down from biggest in house to smallest
			if homelessFish[i].size() < free_rooms:
				#put all homeless fish of this size in this house
				free_rooms -= homelessFish[i].size()
				fish_left -= homelessFish[i].size()
				for fish:Fish in homelessFish[i]:
					fish.go_to_location(house.position)
					fish.homeless = false
				house.current_fish[i] = homelessFish[i]
				homelessFish[i] = []
				continue #next fish size
			else:
				#fill the house with homeless fish of this size
				#free_rooms = 0 #step implied for symmetry, but isn't nessasry b/c of the break
				fish_left -= free_rooms
				var movedObjects = homelessFish[i].slice(-free_rooms)
				for fish:Fish in movedObjects:
					fish.go_to_location(house.position)
					fish.homeless = false
				#move [free_rooms] items from homelessfish to house
				homelessFish[i] = homelessFish[i].slice(0,-free_rooms)
				house.current_fish[i] = movedObjects
				break #next house
		if fish_left <= 0: #less than 0 shouldn't be possible but I dont want to get stuck
			break # no fish left - done with houses
	#go again if needed
	if (startingHomelessFish != homelessFish):
		fishUpdated.emit()
		if fish_left > 0:
			CheckHouses() #if there was any change AND there are fish left - recurse
