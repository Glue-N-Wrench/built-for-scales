extends CanvasLayer

func _input(event):
	if (event.is_echo() || !event.is_pressed()):
		return
	# == handle pause toggle ==
	if Input.is_action_just_pressed("menu_pause"):
		print("mainUI> pause toggle")
		visible = !get_tree().paused
		get_tree().paused = !get_tree().paused

func _on_continue_btn_pressed():
	get_tree().paused = false
	visible=false

func _on_quit_btn_pressed():
	$VBoxContainer/QuitBtn/QuitWindow.show()

func _on_quit_window_confirmed():
	get_tree().quit()

