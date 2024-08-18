extends Node


@onready var fishObjects = { #fish nodes sorted by type
	0: preload("res://Objects/Fish/fish.tscn")
	}

var dayCount = 0
signal updateDay # a signal for the UI
const roundTime = 20 #seconds in a round
var roundTimer = 0
const weekTime = 7 #rounds in a week
var weekTimer = 0

signal updateGameOverTimer
var gameOverCount = 10#seconds till game over
var gameOverTimer = 0
var running = false #to be set true when the game begins

func _process(delta):
	if running == false:
		return
	#==manage the day==
	roundTimer -= delta
	if roundTimer < 0:
		roundTimer = roundTime
		dayCount += 1
		FishManager.makeNewFishBatch(4)
		updateDay.emit()
	#==manage the game over
	if FishManager.getTotalHomeless() > FishManager.maxHomeless:
		gameOverTimer += delta
		updateGameOverTimer.emit()
		if gameOverTimer > gameOverCount:
			$"/root/MainLevel/Camera2D/GameOverScreen".visible=true
			get_tree().paused = true
	elif gameOverTimer > 0:
		gameOverTimer -= delta
		updateGameOverTimer.emit()
