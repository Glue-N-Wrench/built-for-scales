extends Node

var soundSettings = {
	'Music': {
		'mute':false,
		'value':0.7,
		},
	'Ambience': {
		'mute':false,
		'value':1,
		},
	'SFX': {
		'mute':false,
		'value':1,
		},
	}

var controlSettings = {
		"menu_pause": InputMap.action_get_events("menu_pause")[0]
	}

func _ready():
	applySettings()

func applySettings():
	print(soundSettings)
	#==sounds==
	AudioServer.set_bus_mute(1,soundSettings.Music.mute)
	AudioServer.set_bus_volume_db(1,linear_to_db(soundSettings.Music.value))
	AudioServer.set_bus_mute(2,soundSettings.SFX.mute)
	AudioServer.set_bus_volume_db(2,linear_to_db(soundSettings.SFX.value))
	AudioServer.set_bus_mute(5,soundSettings.Ambience.mute)
	AudioServer.set_bus_volume_db(5,linear_to_db(soundSettings.Ambience.value))
	#==controls==
	for setting in controlSettings:
		InputMap.action_erase_events(setting)
		InputMap.action_add_event(setting, controlSettings[setting])
		print(setting,':',InputMap.action_get_events(setting))
	
