@tool
extends Node2D
class_name House

@export var destructable:bool = true
@export var cost:int = 1
@export var refund:int = 1
@export var fish_capacity: int = 1;
@export var max_fish_size: int = 0;
@export var distToGround:int = 64 #in pixels #used for "in the floor" calculation
var current_fish = {
	0:[],
	1:[],
	2:[],
};
@export var shape:Shape2D

func _ready():
	$Area2D/CollisionPolygon2D.polygon = shape.points


func place():#gets called by the builder object when the house first gets placed
	pass

func destroy():#gets called when the house gets "removed"
	pass

