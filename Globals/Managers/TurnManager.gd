extends Node


@onready var fishObjects = { #fish nodes sorted by type
	0: preload("res://Objects/Fish/fish.tscn")
	}

var dayCount = 0
signal updateDay # a signal for the UI
const roundTime = 20 #seconds in a round
var roundTimer = 0
const weekTime = 2 #rounds in a 'week'

signal updateGameOverTimer
const gameOverCount = 10#seconds till game over
var gameOverTimer = 10
signal gameStarted

var timespeed = 1
var timeButton
var forcedTimeSlow = false

#==mange the week rewards==
func weekCheck():
	if dayCount % weekTime == 0:
		$"/root/MainLevel/Camera2D/WeeklyRewards/WeeklyRewardsUI".displayWeeklyRewards()

func reset():
	#reset globals to their starting values
	gameOverTimer = 10
	roundTimer = 0
	dayCount = 0

func _ready():
	gameStarted.emit()

func _on_button_toggled(toggle):
	if toggle:
		timespeed = 3
	else:
		timespeed = 1

func _process(delta):
	if get_tree().get_current_scene() and get_tree().get_current_scene().name != 'MainLevel':
		return
	#==manage the day==
	roundTimer -= delta * timespeed
	if roundTimer < 0:
		roundTimer = roundTime
		dayCount += 1
		weekCheck()
		FishManager.makeNewFishBatch(4)
		updateDay.emit()
	#==manage the game over==
	if FishManager.getTotalHomeless() > FishManager.maxHomeless:
		#Forces button to disable and forces timespeed 1
		if timespeed == 3:
			timespeed = 1
			timeButton.disabled = true
			forcedTimeSlow = true
		
		gameOverTimer -= delta * timespeed
		updateGameOverTimer.emit()
		if gameOverTimer < 0:
			$"/root/MainLevel/Camera2D/GameOverScreen".visible=true
			get_tree().paused = true
	elif gameOverTimer < gameOverCount:
		gameOverTimer += delta * timespeed
		updateGameOverTimer.emit()
	
	#Successfully escaped scenario
	if forcedTimeSlow && FishManager.getTotalHomeless() <= FishManager.maxHomeless:
		forcedTimeSlow = false
		timeButton.disabled = false
		timespeed = 3
