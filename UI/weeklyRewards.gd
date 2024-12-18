extends Control

var rewardRng = RandomNumberGenerator.new()

enum {CHANCE, OBJECTS}
enum {ID, COUNT}
const BOMB = 0
var houseBundles = [
	#[chance, [[id,count][id, count]]]
	[5, [[BOMB, 7]] ],
	[5, [[1,3],[BOMB, 2]] ],
	[5, [[2,3],[BOMB, 2]] ],
	[5, [[3,3],[BOMB, 2]] ],
	[5, [[4,2]] ],
	[5, [[5,1],[BOMB, 4]] ],
	[5, [[6,4],[BOMB, 2]] ],
	[5, [[7,4],[BOMB, 2]] ],
	[5, [[8,3],[BOMB, 2]] ],
	[5, [[11,2],[BOMB, 3]] ],
	[5, [[12,2],[BOMB, 3]] ],
	[5, [[13,3],[BOMB, 2]] ],
	[5, [[14,5]] ],
	[5, [[15,2],[BOMB, 1]] ],
	[5, [[16,2],[BOMB, 1]] ],
	[5, [[17,3],[BOMB, 1]] ],
	[5, [[18,3],[BOMB, 1]] ],
	[5, [[19,3],[BOMB, 1]] ],
	[5, [[20,3],[BOMB, 1]] ],
	[5, [[21,3],[BOMB, 2]] ],
	[5, [[22,3],[BOMB, 2]] ],
	[5, [[23,3],[BOMB, 2]] ],
	[5, [[24,3],[BOMB, 2]] ],
	[5, [[25,3],[BOMB, 2]] ],
	[5, [[26,4],[BOMB, 1]] ],
	[5, [[27,3],[BOMB, 2]] ],
	[5, [[28,3],[BOMB, 4]] ],
	[5, [[29,4],[BOMB, 2]] ],
	[5, [[30,4],[BOMB, 2]] ],
	]

#data used for selection
var bundleOptions = {}#built from InvtoryManager on _ready()
# ^ options represents each house item by chance # {chance:id}
var maxChoice = 0 #built from InvtoryManager on _ready()
# ^ sum of chance #'s in bundleOptions
var shownOptions = [-1,-1,-1] #the 3 reward cards to choose from

func _ready():
	rewardRng.randomize()
	visible = false
	for i in houseBundles.size():
		maxChoice += houseBundles[i][CHANCE]
		bundleOptions[maxChoice] = i

func displayWeeklyRewards():
	get_tree().paused = true
	generateWeeklyOptions()
	$RerollBtn.visible = true
	visible = true

@onready var optionNodes = [
	$"Reward Options Display/Option 1",
	$"Reward Options Display/Option 2",
	$"Reward Options Display/Option 3",
	]

func rollItem():
	#returns an itemID thats not already in the shownOptions
	var choice = rewardRng.randi_range(0,maxChoice)
	while true:
		#wrap around the "score range" until you see an option you havent chosen
		if choice in bundleOptions.keys():
			if bundleOptions[choice] in shownOptions:
				return rollItem() #try again
			else:
				return bundleOptions[choice]
		choice+=1
		choice%=maxChoice

func generateWeeklyOptions():
	#This will display 3 cards for all three options & store the bomb node in the [shownOptions] array
	shownOptions = [-1,-1,-1]#clear for overlap check
	for x in 3:
		#---draw primary item data---
		var choiceID = rollItem()
		shownOptions[x] = choiceID
		var itemID = houseBundles[choiceID][OBJECTS][0][ID]
		optionNodes[x].get_node('Count').text = str(houseBundles[choiceID][OBJECTS][0][COUNT])
		optionNodes[x].get_node('Name').text = BuildingData.Buildings[itemID].displayName
		optionNodes[x].get_node('Description').text = BuildingData.Buildings[itemID].description
		var sprite = BuildingData.Buildings[itemID].get_node_or_null("Sprite2D") as Sprite2D
		if sprite:
			optionNodes[x].get_node('Icon').texture = sprite.texture
		else: 
			optionNodes[x].get_node('Icon').texture = preload("res://assets/bomb.png")
		#---draw secondary item data---
		var secondaryBubble = optionNodes[x].get_node('SecondaryObj')
		if (houseBundles[choiceID][OBJECTS].size()>1):
			secondaryBubble.visible = true
			secondaryBubble.get_node('Count').text = '+'+str(houseBundles[choiceID][OBJECTS][1][COUNT])
			var secondItemID = houseBundles[choiceID][OBJECTS][1][ID]
			var secondSprite = BuildingData.Buildings[secondItemID].get_node_or_null("Sprite2D") as Sprite2D
			if secondSprite:
				secondaryBubble.get_node('Icon').texture = secondSprite.texture
			else: 
				secondaryBubble.get_node('Icon').texture = preload("res://assets/bomb.png")
		else:
			secondaryBubble.visible = false

func giveReward(itemID:int, count:int):
	InventoryManager.addItems(itemID, 5)

func choseOption(buttonNumber: int):
	var bundleID = shownOptions[buttonNumber]
	giveReward(houseBundles[bundleID][OBJECTS][0][ID], houseBundles[bundleID][OBJECTS][0][COUNT])
	if (houseBundles[bundleID][OBJECTS].size()>1):
		giveReward(houseBundles[bundleID][OBJECTS][1][ID], houseBundles[bundleID][OBJECTS][1][COUNT])
	get_tree().paused = false
	visible = false


func _on_reroll_btn_pressed():
	generateWeeklyOptions()
	$RerollBtn.visible = false
