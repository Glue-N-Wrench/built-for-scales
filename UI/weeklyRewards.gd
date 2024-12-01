extends Control

var rewardRng = RandomNumberGenerator.new()

var houseOptions = {}#built from InvtoryManager on _ready()
# ^ options represents each house item by chance # {chance:id}
var maxChoice = 0 #built from InvtoryManager on _ready()
# ^ sum of chance #'s in houseOptions
var shownOptions = [-1,-1,-1] #the 3 reward cards to choose from

func _ready():
	rewardRng.randomize()
	visible = false
	for i in BuildingData.Buildings.size():
		maxChoice += BuildingData.Buildings[i].chance
		houseOptions[maxChoice] = i

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
		if choice in houseOptions.keys():
			if houseOptions[choice] in shownOptions:
				return rollItem() #try again
			else:
				return houseOptions[choice]
		choice+=1
		choice%=maxChoice

func generateWeeklyOptions():
	#This will display 3 cards for all three options & store the bomb node in the [shownOptions] array
	shownOptions = [-1,-1,-1]#clear for overlap check
	for x in 3:
		shownOptions[x] = rollItem()
		var itemID = shownOptions[x]
		optionNodes[x].text = '5' + '\n'\
			+ BuildingData.Buildings[itemID].displayName + '\n'\
			+ BuildingData.Buildings[itemID].description
		var sprite = BuildingData.Buildings[itemID].get_node_or_null("Sprite2D") as Sprite2D
		if sprite:
			optionNodes[x].icon = sprite.texture
		else: 
			optionNodes[x].icon = preload("res://assets/bomb.png")

func giveReward(itemID):
	InventoryManager.addItems(itemID, 5)

func choseOption(buttonNumber: int):
	giveReward(shownOptions[buttonNumber])
	get_tree().paused = false
	visible = false


func _on_reroll_btn_pressed():
	generateWeeklyOptions()
	$RerollBtn.visible = false
