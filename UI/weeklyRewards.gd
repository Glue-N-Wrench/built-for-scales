extends Control

var rewardRng = RandomNumberGenerator.new()
var smallHomeTextures = [ preload("res://Objects/Houses/Textures/house_1x1_a.png"), preload("res://assets/allHouses/house_1x1_b.png") , preload("res://assets/allHouses/house_1x1_c.png"), preload("res://assets/allHouses/house_1x1_d.png")]
var tallHomeTextures = [ preload("res://assets/allHouses/house_1x2_a.png") , preload("res://assets/allHouses/house_1x2_b.png") ]
var tallestHomeTextures = [ preload("res://assets/allHouses/house_1x3_a.png") , preload("res://assets/allHouses/house_1x3_b.png") ]
var wideHomeTextures = [ preload("res://assets/allHouses/house_2x1_a.png") , preload("res://assets/allHouses/house_2x1_b.png") ]
var largeHomeTextures = [ preload("res://assets/allHouses/house_2x2_a.png") , preload("res://assets/allHouses/house_2x2_b.png") , preload("res://assets/allHouses/house_2x2_c.png") ]
var PnQHomeTextures = [ preload("res://assets/allHouses/house_2x2_DL_a.png") , preload("res://assets/allHouses/house_2x2_DR_a.png") ]
var LnJHomeTextures = [ preload("res://assets/allHouses/house_2x2_UL_a.png") , preload("res://assets/allHouses/house_2x2_UR_a.png") ]
var widestHomeTextures = [ preload("res://assets/allHouses/house_3x1_a.png") , preload("res://assets/allHouses/house_3x1_b.png") ]
var mansionTextures = [ preload("res://Objects/Houses/Textures/house_3x2_a.png") , preload("res://Objects/Houses/Textures/house_3x2_b.png") ]
var bombPngTest = preload("res://assets/bomb.png")

var rewardArray = [
	["Bombs", 3, bombPngTest],
	["Small Homes", 3, smallHomeTextures[rewardRng.randi_range(0, 3)]],
	["Wide Homes", 2, wideHomeTextures[rewardRng.randi_range(0, 1)]],
	["Big Home", 1, largeHomeTextures[rewardRng.randi_range(0, 1)]],
	["Mansion", 1, mansionTextures[rewardRng.randi_range(0, 1)]],
	["L & J Homes", 2, LnJHomeTextures[rewardRng.randi_range(0, 1)]],
	["P & Q Homes", 2, PnQHomeTextures[rewardRng.randi_range(0, 1)]],
	["Tall Homes", 2, tallHomeTextures[rewardRng.randi_range(0, 1)]],
	["Widest Home", 1, widestHomeTextures[rewardRng.randi_range(0, 1)]],
	["Tallest Home", 1, tallestHomeTextures[randi_range(0, 1)]]]
@export var options = [[]] #the 3 reward cards to choose from

func _ready():
	visible = false

func displayWeeklyRewards():
	get_tree().paused = true
	generateWeeklyOptions()
	visible = true

func generateWeeklyOptions():
	#This SHOULD display 3 cards for all three options & store the bomb node in the options array
	for x in 3:
		var reward = rewardRng.randi_range(0,9)
		#TODO REPLACE PLACEHOLDER FIRST INDEX [0]s WITH reward
		get_node(options[x][0]).text = str(rewardArray[reward][1]) + " " + rewardArray[reward][0] + "   "
		get_node(options[x][0]).icon = rewardArray[reward][2]
		options[x][1] = rewardArray[reward][0]

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
