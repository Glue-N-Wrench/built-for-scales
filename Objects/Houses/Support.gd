extends TileMap

# Called when the node enters the scene tree for the first time.
func generate():
	position.y = get_parent().distToGround -  get_parent().offset.y
	position.x = get_parent().offset.x
	var startY = global_position.y
	for posX in range(get_parent().supportBase[0],get_parent().supportBase[1]):
		var posY = startY
		var gridY = 0
		var gridArray = [Vector2i(posX, 0)]
		while posY <= ViewManager.floor:
			gridY += 1
			print(posY)
			gridArray.append(Vector2i(posX, gridY))
			posY += tile_set.tile_size.y*2
		print(gridArray)
		set_cells_terrain_connect(0,gridArray,0,0)
	
