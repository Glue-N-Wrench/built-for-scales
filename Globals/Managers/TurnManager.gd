extends Node


@onready var fishObjects = { #fish nodes sorted by type
	0: preload("res://Objects/Fish/fish.tscn")
	}

var dayCount = 0
signal updateDay # a signal for the UI
const roundTime = 10 #seconds in a round
var roundTimer = 0
const weekTime = 7 #rounds in a week
var weekTimer = 0

func _process(delta):
	roundTimer -= delta
	if roundTimer < 0:
		roundTimer = roundTime
		dayCount += 1
		FishManager.makeNewFishBatch(2)
		updateDay.emit()
