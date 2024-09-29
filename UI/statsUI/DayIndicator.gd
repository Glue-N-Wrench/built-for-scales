extends TextureRect

@onready var foghorn_sfx = $"../../foghorn sfx"
var firstTime = true


func _unhandled_input(event):
	if (event.is_echo() || !event.is_pressed()):
		return
	if event.is_action_pressed("set_speed_high"):
		TurnManager.set_fast_mode(true)
		$SpeedButton.set_pressed_no_signal(true)
		$PauseButton.set_pressed_no_signal(false)
	if event.is_action_pressed("set_speed_low"):
		TurnManager.set_fast_mode(false)
		$SpeedButton.set_pressed_no_signal(false)
		$PauseButton.set_pressed_no_signal(false)
	if event.is_action_pressed("time_pause"):
		# \/ this triggers toggle signal
		$PauseButton.set_pressed(!$PauseButton.button_pressed)
		print("unpause", TurnManager.timespeed)
	

func _ready():
	TurnManager.updateDay.connect(_on_day_update)
	TurnManager.timeSpeedButton = $SpeedButton

func _on_day_update():
	$Label.text = "Day\n"+str(TurnManager.dayCount)
	foghorn_sfx.play()

func _process(delta):
	$Sun.rotation = -(TurnManager.roundTimer / TurnManager.roundTime) * TAU

func _on_speed_button_toggled(toggled_on):
	TurnManager.set_fast_mode(toggled_on)
	$PauseButton.set_pressed_no_signal(false)

func _on_pause_button_toggled(toggled_on):
	TurnManager.set_pause(toggled_on)
	$SpeedButton.set_pressed_no_signal(false)
	print("set pause", toggled_on, " at ", TurnManager.timespeed)
