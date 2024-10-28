extends Node2D

var bomb = preload("res://Objects/bomb.tscn")
@onready var tilemap: Node = $"/root/MainLevel/Tilemaps/Breakables"
var distToGround:int = 64
var offset:Vector2 = Vector2(32,32)
@onready var bomb_sfx = $"bomb sfx"
var overlaps = []
var houseOverlaps = []

func _ready():
	$BombAnimator.play("Selecting")

func Explode():
	$BombAnimator.stop()
	$AffectedArea.visible = false
	$BombAnimator.play("Explode")

func onPlace():
	Explode()

func colliderIn(body):
	houseOverlaps.append(body)
	body.get_parent().modulate = Color.LIGHT_CORAL

func colliderOut(body):
	houseOverlaps.erase(body)
	body.get_parent().modulate = Color.WHITE


func _on_bomb_animator_frame_changed():
	if $BombAnimator.frame == 6 and $BombAnimator.animation == "Explode":
		#Effects
		bomb_sfx.play()
		$"Rock Particle Emitter".ActiveEmitter()
		
		var TL = tilemap.get_child(0).local_to_map(position - Vector2(80,80))
		var BR = tilemap.get_child(0).local_to_map(position + Vector2(96,96))
		var destroyedCells = []
		for x in range(TL.x, BR.x):
			for y in range(TL.y, BR.y):
				tilemap.get_child(0).erase_cell(Vector2(x,y))
				tilemap.get_child(1).erase_cell(Vector2(x,y))
				destroyedCells.append(Vector2(x,y))
		tilemap.get_child(0).set_cells_terrain_connect(destroyedCells, 0, -1, false)
		tilemap.get_child(1).set_cells_terrain_connect(destroyedCells, 0, -1, false)
		for house in houseOverlaps:
			house.get_parent().destroy()
	if $BombAnimator.frame == 12:
		queue_free()
