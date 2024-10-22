@tool
extends Node2D
class_name House

@export var junk:bool = false
@export var cost:int = 1
@export var refund:int = 1
@export var fish_capacity: int = 1;
@export var max_fish_size: int = 0;
@export var distToGround:int = 64 #in pixels #used for "in the floor" calculation
@export var offset:Vector2 = Vector2(0,0) #in pixels
@export var supportBase:Vector2 = Vector2(-1,0) #grid values, from-to, inclusive
var overlaps = []

var hasFish = false
const emptyShaderMaterial = preload("res://Objects/Houses/Shaders/empty_house_material.tres")
const normalShaderMaterial = preload("res://Objects/Houses/Shaders/base_house_material.tres")

var current_fish = {
	0:[]
};

@onready var house_placement_sfx = $house_placement_sfx

func onPlace():
	#todo: trigger placement affects
	FishManager.addHouse(self)
	house_placement_sfx.play()
	$Support.generate()

func _ready():
	FishManager.fishUpdated.connect(_on_fish_updated)
	$FishDetails.extraText = "max: "+str(fish_capacity)
	for i in range(max_fish_size+1):
		current_fish[i] = []
	_on_fish_updated()

func _on_fish_updated():
	var newDict = {}
	var fishCount = 0
	for size in current_fish:
		newDict[size] = current_fish[size].size()
		fishCount += current_fish[size].size()
	hasFish = ( fishCount > 0 )
	if hasFish:
		$Sprite2D.material = normalShaderMaterial
	else:
		$Sprite2D.material = emptyShaderMaterial
	$FishDetails.fishData = newDict

func _on_area_2d_mouse_entered():
	if !junk:
		$FishDetails.visible = true

func _on_area_2d_mouse_exited():
	$FishDetails.visible = false

func destroy():
	FishManager.removeHouse(self)
	queue_free()

func colliderIn(body):
	overlaps.append(body)

func colliderOut(body):
	overlaps.erase(body)
