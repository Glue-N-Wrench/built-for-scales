extends Button
@onready var ui_accept_sfx: AudioStreamPlayer = $"../../MainMenuAudio/ui accept sfx"

func _on_pressed():
	$Popup.hide()#hide to reset window position
	$Popup.show()
	ui_accept_sfx.play()
	
