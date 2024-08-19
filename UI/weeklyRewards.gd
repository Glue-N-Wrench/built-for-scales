extends Control

var rng = RandomNumberGenerator.new()
#should store [Name, Amount, PictureNodePath]
#TODO REPLACE PLACEHOLERS WITH PROPER NODES
var rewardArray = [["Bombs", 3, $"res://assets/bomb.png"]]
var options = [[$"HBoxContainer/Option 1", ""], [$"HBoxContainer/Option 2", ""], [$"HBoxContainer/Option 3", ""]]

func displayWeeklyRewards():
	get_tree().paused = true
	var weeklyRewardsUI = $"/root/MainLevel/Camera2D/WeeklyRewards"
	generateWeeklyOptions()
	visible = true

func generateWeeklyOptions():
	#This SHOULD display 3 bombs for all three options & store the bomb node in the options array
	for x in 3:
		var reward = rng.randi_range(0,22)
		#TODO REPLACE PLACEHOLDER FIRST INDEX [0]s WITH reward
		options[x][0].text = rewardArray[0][1] + rewardArray[0][0]
		options[x][0].icon = rewardArray[0][2]
		options[x][1] = rewardArray[0][0]

func giveReward(choice):
	#TODO MAKE LOGIC FOR EACH REWARD
	print("givingReward" + choice)
	match choice:
		"Bombs":
			pass
			#TODO GIVE PLAYER BOMBS HERE

func choseOption(optionNumber):
	giveReward(options[optionNumber][1])
	get_tree().paused = false
	visible = false
