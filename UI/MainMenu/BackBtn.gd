extends Button

func _on_pressed():
	get_parent().hide()
	$"/root/MainAudio/ui2".play()
