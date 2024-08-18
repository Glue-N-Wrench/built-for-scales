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

func _ready():
	applySettings()
	print(AudioServer.get_bus_index('Master'))
	print(AudioServer.get_bus_index('Music'))
	print(AudioServer.get_bus_index('Ambience'))
	print(AudioServer.get_bus_index('Sub_ambience'))

func applySettings():
	print(soundSettings)
	AudioServer.set_bus_mute(1,soundSettings.Music.mute)
	AudioServer.set_bus_volume_db(1,linear_to_db(soundSettings.Music.value))
	AudioServer.set_bus_mute(2,soundSettings.SFX.mute)
	AudioServer.set_bus_volume_db(2,linear_to_db(soundSettings.SFX.value))
	AudioServer.set_bus_mute(5,soundSettings.Ambience.mute)
	AudioServer.set_bus_volume_db(5,linear_to_db(soundSettings.Ambience.value))
	
