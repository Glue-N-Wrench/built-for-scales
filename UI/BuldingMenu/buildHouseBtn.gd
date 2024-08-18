@tool
extends VBoxContainer
@export var houseNumb:int = 0

func _on_texture_button_pressed():
	$"/root/MainLevel/PlacementController".makeSelection(houseNumb)

func _ready():
	var target_house_object:House = PlacementController.Houses[houseNumb].instantiate()
	var target_house_sprite = target_house_object.get_node('Sprite2D')
	if target_house_sprite:
		$TextureButton.texture_normal = target_house_sprite.texture
	var customName = ""
	match target_house_object.max_fish_size:
		0:
			customName += "small "
		1:
			customName += "medium "
		2:
			customName += "big "
		3:
			customName += "Jelly "
	customName += str(target_house_object.fish_capacity)+" room"
	$Label.text = customName
	target_house_object.queue_free()
