@tool
extends Control

@export var fishData =  {}:
	set(x):#set using the housing/homeless dict
		fishData = x
		on_data_change()
@export var extraText:String = "":
	set(x):
		extraText = x
		on_data_change()

var useButton:bool=false
var buttonState:bool=false:
	set(x):
		buttonState = x
		on_data_change()
@export var toggleTextures:Array[Texture2D] = [
	]#0 = default

@export var topTexture:Texture2D
@export var BlankTexture:Texture2D
@export var FishTextures:Array[Texture2D] = [
	]#in fish order
@export var BottomTexture:Texture2D

func on_data_change():
	var customText = ""
	for size in fishData:
		customText += str(fishData[size])+"\n"
	$fishLabel.text = customText
	if extraText:
		$ExtraLabel.text = extraText
	queue_redraw()

static var topSize = 9 #px size of top graphic
static var offsetSize = 25 #size of middle graphics
func _draw():
	draw_texture(topTexture, Vector2(0,0))
	var offset = topSize;
	for size in fishData:
		draw_texture(FishTextures[size], Vector2(0,offset))
		offset += offsetSize
	if extraText:
		draw_texture(BlankTexture, Vector2(0,offset))
		offset += offsetSize
	if useButton:
		draw_texture(BlankTexture, Vector2(0,offset))
		draw_texture(toggleTextures[int(buttonState)], Vector2(0,offset-offsetSize))
		offset += offsetSize
	draw_texture(BottomTexture, Vector2(0,offset))
	size.y = offset+topSize
	position.y = -(offset+topSize)
