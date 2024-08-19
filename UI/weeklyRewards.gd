extends Control

var rng = RandomNumberGenerator.new()
#should store [Name, Amount, NodePath, PictureNodePath]
#TODO REPLACE PLACEHOLERS WITH PROPER NODES
var rewardArray = [["Bombs", $"Placeholder", 3, $"res://assets/bomb.png"]]
var options

func displayWeeklyRewards():
	get_tree().paused
	var weeklyRewardsUI = $"/root/MainLevel/Camera2D/WeeklyRewards"
	visible=true
	options[0] = $"HBoxContainer/Option 1"
	options[1] = $"HBoxContainer/Option 2"
	options[2] = $"HBoxContainer/Option 3"

func generateWeeklyOptions():
	for x in 3:
		var reward = rng.randi_range(0,22)
		#TODO REPLACE PLACEHOLDER [0]s WITH reward
		#both first index [0]s here are placeholders
		
		#this SHOULD make an options text say "3 Bombs"
		options[x].text = rewardArray[0][2] + rewardArray[0][0]
		#this SHOULD make an options Icon bomb.png
		options[x].icon = rewardArray[0][3]
		
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
