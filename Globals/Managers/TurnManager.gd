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
#signal gameStarted MOVED TO CAMERA2D

var timespeed = 1
var forcedTimeSlow = false
var timePaused = false #note: this is different than godot tree pausing
var timeSpeedButton:TextureButton

#==mange the week rewards==
func weekCheck():
	if dayCount % weekTime == 0:
		$"/root/MainLevel/Camera2D/WeeklyRewards/WeeklyRewardsUI".displayWeeklyRewards()

func reset():
	#reset globals to their starting values
	gameOverTimer = 10
	roundTimer = 0
	dayCount = 0

#func _ready():
	#only plays music for title screen working on fixing this
		#gameStarted.emit()

func set_fast_mode(toggle:bool):
	if toggle == true:
		timespeed = 3
	else:
		timespeed = 1

func set_pause(toggle:bool):
	#this is independant from godot's get_tree().paused
	if toggle == true:
		timespeed = 0
	else:
		timespeed = 1
	

const houseShader = preload("res://Objects/Houses/Shaders/base_house_material.tres")
const houseEmptyShader = preload("res://Objects/Houses/Shaders/empty_house_material.tres")

func _process(delta):
	if get_tree().get_current_scene() and get_tree().get_current_scene().name != 'MainLevel':
		return
	#==manage the day==
	roundTimer -= delta * timespeed
	houseShader.set_shader_parameter("time", TurnManager.roundTimer/TurnManager.roundTime)
	houseEmptyShader.set_shader_parameter("time", TurnManager.roundTimer/TurnManager.roundTime)
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
			timeSpeedButton.disabled = true
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
		timeSpeedButton.disabled = false
		timespeed = 3
