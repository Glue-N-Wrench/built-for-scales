extends AnimatedSprite2D
class_name Fish
# The fish object is a visual indicator for the change in fish
# They are purley cosmetic
# See fishMaster for the behavior of these fish
@onready var fish_enter_sfx = $"fish enter sfx"


@export var speed:int = 200 #pixels per second
var homeless:bool = true
var wanderClock = 0#counts down between homeless fish wandering
var wanderTime = 5;#seconds between wander for fish movement
var target_location:Vector2 = Vector2(0,0)# where the fish will swim to

func go_to_location(position):
	target_location = position
	visible = true
	set_process(true);#fish pause when they're not thinking

func _ready():
	wanderClock = randi_range(0,wanderTime)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#modulate = Color.BLUE #DEBUGGING
	if homeless:
		#modulate = Color.RED #DEBUGGING
		wanderClock -= delta
		if wanderClock < 0:
			#TODO: when map-range is determined change this \/ X to be the width of the map
			#pollish idea: each size of fish can wander in a different Y range
			target_location = Vector2(randi_range(-300,300), randi_range(100,200))
			wanderClock = wanderTime
	var difference = target_location - position
	if difference.length() < 10 and not homeless:
		#fish_enter_sfx.play()
		visible = false
		set_process(false);#pause fish when they're not thinking
	position += difference.limit_length(speed * delta * $"/root/TurnManager".timespeed)
	flip_h = difference.x < 0
