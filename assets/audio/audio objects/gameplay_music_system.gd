extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void: #Pete TODO: add functionality to change to gameplay music vs main menu music
	MainAudio.stop_music()
	MainAudio.play_music()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
