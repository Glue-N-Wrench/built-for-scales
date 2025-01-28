extends House

var state = true
@export var Textures:Array[Texture2D] = [
	]#0 = default

func _ready():
	$Sprite2D.texture = Textures[1]
	fish_capacity = 1;
	max_fish_size = 2; #catfish
	$FishDetails.useButton = true
	super._ready()

func toggle(newState):
	$"Bubble&DustEffect".EmitParticles()
	print("toggle:",state)
	state = newState
	if newState:
		$Sprite2D.texture = Textures[1]
		fish_capacity = 5;
		max_fish_size = 0; #anchovi
	else:
		$Sprite2D.texture = Textures[0]
		fish_capacity = 1;
		max_fish_size = 2; #catfish
	$FishDetails.buttonState = state
	$FishDetails.extraText = "max: "+str(fish_capacity)
	#dump fish
	for size in current_fish:
		FishManager.homelessFish[size].append_array(current_fish[size])
		for fish in current_fish[size]:
			fish.become_homeless()
		current_fish[size] = []
	FishManager.CheckHouses()#re-calculate fish housing

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_pressed() && event is InputEventMouseButton:
		toggle(!state)
