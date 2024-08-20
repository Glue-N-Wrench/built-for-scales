extends Button
@onready var go_back_sfx = $"../../../../go back sfx"

func _on_pressed():
	get_parent().hide()
	go_back_sfx.play()
	
