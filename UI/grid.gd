extends Node2D

#this can be drawn on any stationary world object

const lineColor = Color(1,1,1,0.3)
const borderColor = Color(0,1,1,0.4)

var showGrid = false
var gridGrowSpeed = 0.6 #px/s at normal speed

func _process(delta):
	if ViewManager.gridLimitSides < ViewManager.maxGridLimit.x \
		and ViewManager.gridLimitTop > ViewManager.maxGridLimit.y:
		ViewManager.gridLimitSides += delta * gridGrowSpeed * $"/root/TurnManager".timespeed
		ViewManager.gridLimitTop -= delta * gridGrowSpeed * $"/root/TurnManager".timespeed
	queue_redraw()


func _draw():
	if showGrid == true:
		var startOffsetX = fmod(-ViewManager.gridLimitSides, ViewManager.gridSize.y)
		for xPos in range(-ViewManager.gridLimitSides-startOffsetX,ViewManager.gridLimitSides,ViewManager.gridSize.x):
			draw_line(Vector2(xPos,ViewManager.floor),Vector2(xPos, ViewManager.gridLimitTop),lineColor,2)
		var startOffsetY = fmod(ViewManager.gridLimitTop, ViewManager.gridSize.y)
		for yPos in range(ViewManager.gridLimitTop-startOffsetY,ViewManager.floor,ViewManager.gridSize.y):
			draw_line(Vector2(-ViewManager.gridLimitSides,yPos),Vector2(ViewManager.gridLimitSides,yPos),lineColor,2)
		draw_line(Vector2(-ViewManager.gridLimitSides,ViewManager.floor), Vector2(-ViewManager.gridLimitSides,ViewManager.gridLimitTop), borderColor,2)#right
		draw_line(Vector2(ViewManager.gridLimitSides,ViewManager.floor), Vector2(ViewManager.gridLimitSides,ViewManager.gridLimitTop), borderColor,2)#left
		draw_line(Vector2(ViewManager.gridLimitSides,ViewManager.floor), Vector2(-ViewManager.gridLimitSides,ViewManager.floor), borderColor,2)	#bottom
		draw_line(Vector2(ViewManager.gridLimitSides,ViewManager.gridLimitTop), Vector2(-ViewManager.gridLimitSides,ViewManager.gridLimitTop), borderColor,2)#top
