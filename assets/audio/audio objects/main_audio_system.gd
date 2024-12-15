extends Node

@onready var main_menu_music: AudioStreamPlayer = $"main menu music"
@onready var gameplay_music: AudioStreamPlayer2D = $"gameplay music"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func play_game_music():
	gameplay_music.play()
	
func stop_game_music():
	gameplay_music.stop()
	
func play_music():
	main_menu_music.play()
	
func stop_music():
	main_menu_music.stop()
