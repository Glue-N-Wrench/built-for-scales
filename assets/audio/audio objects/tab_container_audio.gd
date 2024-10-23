extends Node
@onready var switch_tab_sfx: AudioStreamPlayer = $"switch tab sfx"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_tab_container_tab_changed(tab: int) -> void:
	#switch_tab_sfx.play()
	print('play tab audio')
	pass # Replace with function body.
