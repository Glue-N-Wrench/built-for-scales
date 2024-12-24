extends Node

const gridSize = Vector2i(64,64) #size of 1 grid cell
var maxGridLimit = Vector2i(972, -832) #max size grid can grow to
var gridLimitSides = 384 # limit left and right of center in pixels
const floor = 335 # pos of floor in pixels
var gridLimitTop = -120 # pos of vertical limit in pixels
const gridPosition = Vector2i(192,0)

func reset():
	gridLimitSides = 384
	gridLimitTop = -120
