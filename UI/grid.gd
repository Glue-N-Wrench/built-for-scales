extends Node2D

#this can be drawn on any stationary world object

const lineColor = Color(1,1,1,0.5)
const borderColor = Color(0,1,1,0.7)
func _draw():
	var startOffsetX = -ViewManager.gridLimitSides % ViewManager.gridSize.y
	for xPos in range(-ViewManager.gridLimitSides-startOffsetX,ViewManager.gridLimitSides,ViewManager.gridSize.x):
		draw_line(Vector2(xPos,ViewManager.floor),Vector2(xPos, ViewManager.gridLimitTop),lineColor,2)
	var startOffsetY = ViewManager.gridLimitTop % ViewManager.gridSize.y
	for yPos in range(ViewManager.gridLimitTop-startOffsetY,ViewManager.floor,ViewManager.gridSize.y):
		draw_line(Vector2(-ViewManager.gridLimitSides,yPos),Vector2(ViewManager.gridLimitSides,yPos),lineColor,1)
	draw_line(Vector2(-ViewManager.gridLimitSides,ViewManager.floor), Vector2(-ViewManager.gridLimitSides,ViewManager.gridLimitTop), borderColor,2)#right
	draw_line(Vector2(ViewManager.gridLimitSides,ViewManager.floor), Vector2(ViewManager.gridLimitSides,ViewManager.gridLimitTop), borderColor,2)#left
	draw_line(Vector2(ViewManager.gridLimitSides,ViewManager.floor), Vector2(-ViewManager.gridLimitSides,ViewManager.floor), borderColor,2)	#bottom
	draw_line(Vector2(ViewManager.gridLimitSides,ViewManager.gridLimitTop), Vector2(-ViewManager.gridLimitSides,ViewManager.gridLimitTop), borderColor,2)#top
