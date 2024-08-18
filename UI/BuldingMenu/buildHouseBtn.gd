@tool
extends TextureButton
@export var houseNumb:int = 0

func _on_pressed():
	$"/root/MainLevel/PlacementController".makeSelection(houseNumb)

func _ready():
	var target_house_object:Node = PlacementController.Houses[houseNumb].instantiate()
	var target_house_sprite = target_house_object.get_node('Sprite2D')
	if target_house_sprite:
		texture_normal = target_house_sprite.texture
	target_house_object.queue_free()
	
