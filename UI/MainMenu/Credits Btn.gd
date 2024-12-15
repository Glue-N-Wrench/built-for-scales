extends Button
@onready var ui_open_option_sfx: AudioStreamPlayer2D = $"../../UI Open Panel SFX"



func _on_pressed():
	ui_open_option_sfx.play()
	$Popup.hide()#hide to reset window position
	$Popup.show()
	
	
