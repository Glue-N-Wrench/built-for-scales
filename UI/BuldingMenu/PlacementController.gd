extends Node2D
#this class manages the spawning and placement of all the blocks
#keep an eye out for the staic variables to call from other places

var selectedObject:House = null
var selectedObjectID:int = 0
var validPlace:bool = false

# Called when a button is pressed
func makeSelection(selection:int):
	if selectedObject != null:
			selectedObject.queue_free()
	selectedObjectID = selection
	selectedObject = InventoryManager.Buildings[selection].packedScene.instantiate()
	add_child(selectedObject)

func _unhandled_input(event):
	# Mouse in viewport coordinates.
	if selectedObject != null:
		if event is InputEventMouseButton and validPlace == true:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				remove_child(selectedObject)
				get_tree().root.add_child(selectedObject)
				selectedObject.set_process(true)
				selectedObject.position = get_viewport().get_camera_2d()\
					.get_global_mouse_position().snapped(ViewManager.gridSize)+selectedObject.offset
				selectedObject.modulate = Color.WHITE
				selectedObject.onPlace()
				selectedObject = null
				InventoryManager.decrementItem(selectedObjectID)
			elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
				#cancel placement
				selectedObject.queue_free()
				selectedObject = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#position = get_viewport().get_mouse_position()+get_viewport().get_camera_2d().position
	if selectedObject != null:
		selectedObject.get_node("FishDetails").visible = false #this is really scrappy, find a way to not need this later
		position = get_global_mouse_position().snapped(ViewManager.gridSize)
		#== restrict placement to bounds ==
		if global_position.y+selectedObject.distToGround > ViewManager.floor \
			or absf(global_position.x) > ViewManager.gridLimitSides \
			or global_position.y < ViewManager.gridLimitTop:
			selectedObject.modulate = Color(1,0,0,0.5)#red
			validPlace = false
			return
		# == prevent collision overlaps
		var overlaps = \
			selectedObject.get_node('Area2D').has_overlapping_areas() or \
			selectedObject.get_node('Area2D').has_overlapping_bodies()
		if overlaps == false:
			selectedObject.modulate = Color(0,1,0,0.5)#blue
			validPlace = true
		else:
			selectedObject.modulate = Color(1,0,0,0.5)#red
			validPlace = false
