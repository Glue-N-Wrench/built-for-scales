extends Button
@onready var ui_sound2 = $"../../../../audio/ui2"

func _on_pressed():
	get_parent().hide()
	ui_sound2.play()
