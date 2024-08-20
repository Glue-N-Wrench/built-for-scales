extends Resource
class_name HouseInfo

var name:String #display name in the cards
var description: String #display info on expand
var chance:int #chance of the house to show up as a reward
var texture:Texture2D #image shown in card
var packedScene:PackedScene  #scene of the house to load
var rewardAmount:int #ammount of item to give from reward

func _init(newName:String, newDescription:String, newChance:int, newTexture:Texture2D, newPackedScene:PackedScene, newAmount:int):
	name = newName
	description = newDescription
	chance = newChance
	texture = newTexture
	packedScene = newPackedScene
	rewardAmount = newAmount
