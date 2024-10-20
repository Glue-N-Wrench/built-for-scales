extends CanvasLayer

func _on_quit_btn_pressed():
	get_tree().quit()


func _on_return_btn_pressed():
	FishManager.reset()
	InventoryManager.reset()
	TurnManager.reset()
	ViewManager.reset()
	get_tree().paused = false
	get_tree().reload_current_scene()
