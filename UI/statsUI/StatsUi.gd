extends VBoxContainer

#the statsUI does everything it can to keep the UI children up to date with the Global vars

# Called when the node enters the scene tree for the first time.
func _ready():
	FishManager.fishUpdated.connect(_on_fish_updated)

func _on_fish_updated():
	$HomelessFish.text = \
		"HomelessFish: "+str(FishManager.homelessFish[0].size())+"/"+str(FishManager.maxHomeless)
	$HomelessFish/FishDetails.fishData = FishManager.homelessFish


func _on_homeless_fish_pressed():
	$HomelessFish/FishDetails.visible = !$HomelessFish/FishDetails.visible
