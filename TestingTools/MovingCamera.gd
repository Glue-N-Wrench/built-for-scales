extends Camera2D

func _process(delta):
	if Input.is_key_pressed(KEY_LEFT):
		position += Vector2(-30,0)
	if Input.is_key_pressed(KEY_RIGHT):
		position += Vector2(30,0)
