extends Button

func _on_pressed():
	$Popup.hide()#hide to reset window position
	$Popup.show()
	$"/root/MainAudio/ui1".play
