extends Node

signal fishUpdated #should be signaled when homelessFish gets changed

@onready var fishObjects = {
	0: preload("res://Objects/Fish/fish.tscn")
}

var homelessFish = {
	0:[]
} #array of homeless fish counts sorted by type

	
func makeNewFishBatch(points:int):
	#TODO: make this more intresting
	for i in points:
		spawnFish(0)
	fishUpdated.emit()

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
	newFish.target_location  = Vector2(0,0)
	add_child(newFish)
	homelessFish[type].append(newFish)
