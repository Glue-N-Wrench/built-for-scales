#simple underwater ambience system, plays random sounds at random intervals with random pitch and panning 
extends Node2D
@onready var base_underwater_audio = $base_underwater_audio
@onready var audio_one_shots = $"audio one shots"

func _ready():
	print("water audio system ready")


func _on_timer_timeout():
	audio_one_shots.play()
	pass # Replace with function body.
