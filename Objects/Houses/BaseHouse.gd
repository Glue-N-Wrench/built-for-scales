@tool
extends Node2D

@export var destructable:bool = true
@export var cost:int = 1
@export var refund:int = 1
@export var fish_capacity: int = 1;
@export var max_fish_size: int = 1;
var current_fish = [];#array of fish sizes, each number representing a fish
@export var shape:Shape2D

func _ready():
	$Area2D/CollisionPolygon2D.polygon = shape.points


func place():#gets called by the builder object when the house first gets placed
	pass

func destroy():#gets called when the house gets "removed"
	pass

