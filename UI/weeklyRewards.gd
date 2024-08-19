extends Control

var rng = RandomNumberGenerator.new()
#should store [Name, Amount, TextureNodePath]
@export
var rewardArray = [["Bombs", 3, ""]]
@export var options = [[]]

func _ready():
	displayWeeklyRewards()
	#visible = false

func displayWeeklyRewards():
	get_tree().paused = true
	generateWeeklyOptions()
	visible = true

func generateWeeklyOptions():
	#This SHOULD display 3 bombs for all three options & store the bomb node in the options array
	for x in 3:
		var reward = rng.randi_range(0,22)
		#TODO REPLACE PLACEHOLDER FIRST INDEX [0]s WITH reward
		get_node(options[x][0]).text = str(rewardArray[0][1]) + " " + rewardArray[0][0] + "   "
		get_node(options[x][0]).icon = get_node(rewardArray[0][2]).texture
		options[x][1] = rewardArray[0][0]

func giveReward(choice):
	#TODO MAKE LOGIC FOR EACH REWARD
	match choice:
		"Bombs":
			pass
			#TODO GIVE PLAYER BOMBS HERE

func choseOption(optionNumber: int):
	giveReward(options[optionNumber][1])
	get_tree().paused = false
	visible = false
