extends Node2D

var selectedObject:Node = null

@onready var Houses = {
	0: preload("res://Objects/Houses/base_house.tscn")
	}

# Called when the node enters the scene tree for the first time.
func makeSelection(selection:int):
	if selectedObject != null:
			selectedObject.queue_free()
	selectedObject = Houses[selection].instantiate()
	add_child(selectedObject)

func _input(event):
	# Mouse in viewport coordinates.
	if selectedObject != null:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				remove_child(selectedObject)
				get_tree().root.add_child(selectedObject)
				selectedObject.set_process(true)
				selectedObject.position = get_viewport().get_camera_2d().get_global_mouse_position()
				selectedObject = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#position = get_viewport().get_mouse_position()+get_viewport().get_camera_2d().position
	position = get_global_mouse_position()
	
func _draw():
	draw_circle(Vector2.ZERO, 36, Color(0,1,0,0.5))
