extends Node2D

#place every house on the screen somewhere
func _ready():
	for ID in len(BuildingData.Buildings):
		#==place house==
		var selectedObject:Node2D = BuildingData.Buildings[ID].duplicate()
		selectedObject.use_parent_material = false
		get_tree().get_current_scene().add_child(selectedObject)
		selectedObject.position = Vector2(ID*192, 200-(ID%2*128))
		selectedObject.onPlace()
		#==place label==
		var labelObject = Label.new()
		labelObject.text = str(ID) + ": " + selectedObject.displayName
		labelObject.position = Vector2(ID*192, 100-(ID%2*128))
		labelObject.z_index = 1
		get_tree().get_current_scene().add_child(labelObject)
		
