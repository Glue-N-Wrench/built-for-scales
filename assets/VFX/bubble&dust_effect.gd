extends Node2D

#Not much to this funciton it just emits particles duh

func EmitParticles():
	$BubbleParticles.emitting = true
	$DustParticle.emitting = true
