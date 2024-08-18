extends VBoxContainer
#the statsUI does everything it can to keep the UI children up to date with the Global vars

# Called when the node enters the scene tree for the first time.
func _ready():
	FishManager.fishUpdated.connect(_on_fish_updated)

func _on_fish_updated():
	$MainLabel/Label.text = \
		str(FishManager.getTotalHomeless())+"/"+str(FishManager.maxHomeless)
	$FishNumbers/fishLabel0.text = str(FishManager.homelessFish[0].size())
	$FishNumbers/fishLabel1.text = str(FishManager.homelessFish[1].size())
	$FishNumbers/fishLabel2.text = str(FishManager.homelessFish[2].size())
	#$FishNumbers/fishLabel3.text = str(FishManager.homelessFish[3].size())
