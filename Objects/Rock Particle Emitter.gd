extends Node
# Calls and ensures Emitter stays alive

func ActiveEmitter():
	$Emitter.position = get_parent().position
	$Emitter.position = get_parent().position+get_parent().offset
	$Emitter.emitting = true
	reparent(get_parent().get_parent())


func _on_timer_timeout():
	queue_free()
