extends Button
@onready var open_panel_sfx = $"/root/MainAudio/open panel sfx"


func _on_pressed():
	$Popup.hide()#hide to reset window position
	$Popup.show()
	open_panel_sfx.play
	
