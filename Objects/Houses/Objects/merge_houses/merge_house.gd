extends House

@export var combinedHouse = preload("res://Objects/Houses/Objects/merge_houses/merge_house_large.tscn").instantiate()

var partnerFound = false
var partnerHouse = null
#var middlePosition = null

const clockSpeed = 2 #the speed the clock rotates
func _process(delta: float) -> void:
	if partnerHouse:
		$ClockSprite.rotation += delta*TurnManager.timespeed*clockSpeed
		if $ClockSprite.rotation > 2*PI:
			get_tree().get_current_scene().add_child(combinedHouse)
			combinedHouse.position = $ClockSprite.global_position
			combinedHouse.get_node("Bubble&DustEffect").EmitParticles()
			combinedHouse.onPlace()
			partnerHouse.destroy()
			destroy()#destroy this house at end

func onPlace():
	super.onPlace()
	$NeighborArea/CollisionShape2D.disabled = false

func _on_neighbor_area_area_entered(area: Area2D) -> void:
	#check for other house
	# as of writing this house picks the later house in the scene, ie: the newest house
	# consider prefering left or right for gameplay reasons
	if partnerFound: return
	
	partnerHouse = area.get_parent()
	if partnerHouse.partnerFound:
		partnerHouse = null
		return
	partnerHouse.partnerFound = true
	partnerFound = true
	
	var newHousePos = (partnerHouse.position + position)/2
	newHousePos = newHousePos.snapped(ViewManager.gridSize)+combinedHouse.offset
	$ClockSprite.visible = true
	$ClockSprite.global_position = newHousePos
