extends Node2D

var bomb = preload("res://Objects/bomb.tscn")
@onready var tilemap: TileMap = $"/root/MainLevel/Tilemaps/Breakables"
var distToGround:int = 64
var offset:Vector2 = Vector2(32,32)
@onready var bomb_sfx = $"bomb sfx"

func Explode():
	$AffectedArea.visible = false
	$BombAnimator.play("Explode")

func onPlace():
	Explode()


func _on_bomb_animator_frame_changed():
	if $BombAnimator.frame == 6 and $BombAnimator.animation == "Explode":
		bomb_sfx.play()
		var TL = tilemap.local_to_map(position - Vector2(80,80))
		var BR = tilemap.local_to_map(position + Vector2(96,96))
		var destroyedCells = []
		for x in range(TL.x, BR.x):
			for y in range(TL.y, BR.y):
				tilemap.erase_cell(0, Vector2(x,y))
				tilemap.erase_cell(1, Vector2(x,y))
				destroyedCells.append(Vector2(x,y))
		
		tilemap.set_cells_terrain_connect(0, destroyedCells, 0, -1, false)
		tilemap.set_cells_terrain_connect(1, destroyedCells, 0, -1, false)
	if $BombAnimator.frame == 12:
		queue_free()
