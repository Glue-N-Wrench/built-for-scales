@tool
extends Control

@export var fishData =  {}:
	set(x):#set using the housing/homeless dict
		fishData = x
		on_data_change()
		queue_redraw()
@export var extraText:String = "":
	set(x):
		extraText = x
		on_data_change()
		queue_redraw()

@export var topTexture:Texture2D
@export var BlankTexture:Texture2D
@export var FishTextures:Array[Texture2D] = [
	]#in fish order
@export var BottomTexture:Texture2D

func on_data_change():
	queue_redraw()
	var customText = ""
	for size in fishData:
		customText += str(fishData[size])+"\n"
	$fishLabel.text = customText
	if extraText:
		$ExtraLabel.text = extraText

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
	draw_texture(BottomTexture, Vector2(0,offset))
	size.y = offset+topSize
	position.y = -(offset+topSize)
