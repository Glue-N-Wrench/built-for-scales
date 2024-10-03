extends Node

const gridSize = Vector2i(64,64) #size of 1 grid cell
var maxGridLimit = Vector2i(1260, -850) #max size grid can grow to
var gridLimitSides = 500 # limit left and right of center in pixels
const floor = 335 # pos of floor in pixels
var gridLimitTop = -120 # pos of vertical limit in pixels


func reset():
	gridLimitSides = 500
	gridLimitTop = -160
