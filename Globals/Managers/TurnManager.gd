extends Node


@onready var fishObjects = { #fish nodes sorted by type
	0: preload("res://Objects/Fish/fish.tscn")
	}

var roundTime = 2 #seconds in a round
var roundTimer = 0
var weekTime = 7 #rounds in a week
var weekTimer = 0


func _process(delta):
	roundTimer -= delta
	if roundTimer < 0:
		roundTimer = roundTime
		FishManager.makeNewFishBatch(2)
