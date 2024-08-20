extends CanvasLayer

func _on_quit_btn_pressed():
	get_tree().quit()


func _on_return_btn_pressed():
	get_tree().reload_current_scene()
