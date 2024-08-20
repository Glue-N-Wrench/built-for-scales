extends Control

var rewardRng = RandomNumberGenerator.new()

var houseOptions = {}#built from InvtoryManager on _ready()
# ^ options represents each house item by chance # {chance:id}
var maxChoice = 0 #built from InvtoryManager on _ready()
# ^ sum of chance #'s in houseOptions
var shownOptions = [0,0,0] #the 3 reward cards to choose from

func _ready():
	rewardRng.randomize()
	visible = false
	for i in InventoryManager.Buildings.size():
		maxChoice += InventoryManager.Buildings[i].chance
		houseOptions[maxChoice] = i

func displayWeeklyRewards():
	get_tree().paused = true
	generateWeeklyOptions()
	visible = true

@onready var optionNodes = [
	$"Reward Options Display/Option 1",
	$"Reward Options Display/Option 2",
	$"Reward Options Display/Option 3",
	]

func generateWeeklyOptions():
	#This SHOULD display 3 cards for all three options & store the bomb node in the options array
	for x in 3:
		var choice = rewardRng.randi_range(0,maxChoice)
		while true:
			if choice in houseOptions.keys():
				shownOptions[x] = houseOptions[choice]
				break
			choice+=1
		var itemID = shownOptions[x]
		optionNodes[x].text = str(InventoryManager.Buildings[itemID].rewardAmount) + 'x '\
			+ InventoryManager.Buildings[itemID].name + '\n'\
			+ InventoryManager.Buildings[itemID].description
		optionNodes[x].icon = InventoryManager.Buildings[itemID].texture

func giveReward(itemID):
	InventoryManager.addItems(itemID, InventoryManager.Buildings[itemID].rewardAmount)

func choseOption(buttonNumber: int):
	giveReward(shownOptions[buttonNumber])
	get_tree().paused = false
	visible = false
