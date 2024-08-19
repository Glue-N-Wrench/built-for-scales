extends ColorRect

var open = true
const speed = 12

func _process(delta):
	if open:
		if position.x>0:
			position.x-=speed
	else:
		if position.x<125:
			position.x+=speed

func _on_tray_button_pressed():
	if open:
		open = false
		$TrayButton.text = '<'
	else:
		open = true
		$TrayButton.text = '>'
