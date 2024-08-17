extends Button
@onready var ui_sound1 = $"../../audio/ui1"


func _ready():
	$Popup.hide()
	

func _on_pressed():
	$Popup.hide()#hide to reset window position
	$Popup.show()
	ui_sound1.play()
