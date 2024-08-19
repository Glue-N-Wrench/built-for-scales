extends Node


@onready var fishObjects = { #fish nodes sorted by type
	0: preload("res://Objects/Fish/fish.tscn")
	}

var dayCount = 0
signal updateDay # a signal for the UI
const roundTime = 20 #seconds in a round
var roundTimer = 0
#TODO change this back to 7
const weekTime = 2 #rounds in a week
#var weekTimer = 0 not needed we can just use the amount of days and modulus it by weektime

signal updateGameOverTimer
var gameOverCount = 10#seconds till game over
var gameOverTimer = 10

#==mange the week rewards==
func weekCheck():
	if dayCount % weekTime == 0:
		$"/root/MainLevel/Camera2D/WeeklyRewards/WeeklyRewardsUI".displayWeeklyRewards()

func _process(delta):
	if get_tree().get_current_scene() and get_tree().get_current_scene().name != 'MainLevel':
		return
	#==manage the day==
	roundTimer -= delta
	if roundTimer < 0:
		roundTimer = roundTime
		dayCount += 1
		weekCheck()
		FishManager.makeNewFishBatch(4)
		updateDay.emit()
	#==manage the game over
	if FishManager.getTotalHomeless() > FishManager.maxHomeless:
		gameOverTimer -= delta
		updateGameOverTimer.emit()
		if gameOverTimer < 0:
			$"/root/MainLevel/Camera2D/GameOverScreen".visible=true
			get_tree().paused = true
	elif gameOverTimer < gameOverCount:
		gameOverTimer += delta
		updateGameOverTimer.emit()
