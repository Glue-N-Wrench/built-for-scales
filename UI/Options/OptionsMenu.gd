extends Window
#The big gimic with this option menu is that it doesn't change global options untill you press apply

var selectedSoundOptions = OptionsMan.soundSettings.duplicate(true)
const soundControl = preload("res://UI/Options/sound_control.tscn")
var selectedControlOptions = OptionsMan.controlSettings.duplicate(true)
const controlControl = preload("res://UI/Options/controls_control.tscn")
@onready var ui_accept_sfx: AudioStreamPlayer = $"../../../MainMenuAudio/ui accept sfx"
@onready var go_back_sfx: AudioStreamPlayer = $"../../../MainMenuAudio/go back sfx"


func _ready():
	#==build sound options ==
	for option in selectedSoundOptions:
		var newControl = soundControl.instantiate()
		$TabContainer/Sound.add_child(newControl)
		newControl.name = option
		newControl.get_node('Label').text = option
		newControl.get_node('MuteBtn').button_pressed = selectedSoundOptions[option]['mute']
		newControl.get_node('Slider').value = selectedSoundOptions[option]['value']
	#== build control options == 
	for option in selectedControlOptions:
		var newControl = controlControl.instantiate()
		$TabContainer/Controls.add_child(newControl)
		newControl.name = option
		newControl.get_node('Label').text = option
		print("loaded:",selectedControlOptions[option])
		if selectedControlOptions[option]:
			newControl.get_node('Key').text = selectedControlOptions[option].as_text_physical_keycode()


func resetOptions():
	#undo changes back to the global settings
	#== sound options == 
	for option in selectedSoundOptions:
		var settingNode = $TabContainer/Sound.get_node(option)
		settingNode.get_node('MuteBtn').button_pressed = selectedSoundOptions[option]['mute']
		settingNode.get_node('Slider').value = selectedSoundOptions[option]['value']
	#== control options == 
	for option in selectedControlOptions:
		var settingNode = $TabContainer/Controls.get_node(option)
		settingNode.get_node('Key').text = selectedControlOptions[option].as_text_physical_keycode()

func _on_apply_but_pressed():
	#==apply sound options ==
	for option in selectedSoundOptions:
		var settingNode = $TabContainer/Sound.get_node(option)
		OptionsMan.soundSettings[option]['mute'] = settingNode.get_node('MuteBtn').button_pressed
		OptionsMan.soundSettings[option]['value'] = settingNode.get_node('Slider').value
	#== control options == 
	for option in selectedControlOptions:
		var settingNode = $TabContainer/Controls.get_node(option)
		OptionsMan.controlSettings[option] = settingNode.get_node('Key').key
	OptionsMan.applySettings()
	if ui_accept_sfx:
		ui_accept_sfx.play()

func _on_close_but_pressed():
	resetOptions()
	hide()
	go_back_sfx.play()
	

func _on_option_btn_pressed():
	#this needs to be connect to a signal from outside the menu
	show()
	if ui_accept_sfx:
		ui_accept_sfx.play()

func _on_close_requested():
	resetOptions()
	hide()
	
