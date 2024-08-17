extends AnimatedSprite2D

# The fish object is a visual indicator for the change in fish
# They are purley cosmetic
# See fishMaster for the behavior of these fish

@export var speed:int = 100
var target_location:Vector2 = Vector2(0,0)# where the fish will swim to

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var difference = target_location - position
	position += difference.limit_length(speed*delta)
	flip_h = difference.x < 0
