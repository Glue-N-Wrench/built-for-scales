extends AnimatedSprite2D
class_name Fish
# The fish object is a visual indicator for the change in fish
# They are purley cosmetic
# See fishMaster for the behavior of these fish
@onready var fish_enter_sfx = $"fish enter sfx"


@export var speed:int = 200 #pixels per second
@export var wanderZone = 0.5 #% of grid height
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
		wanderClock -= delta * TurnManager.timespeed
		if wanderClock < 0:
			var wanderLimit = ViewManager.gridLimitSides * 0.8
			var wanderHeight = ViewManager.floor + ((ViewManager.gridLimitTop - ViewManager.floor) * wanderZone)
			target_location = Vector2(randi_range(-wanderLimit,wanderLimit), randi_range(wanderHeight-200,wanderHeight+200))
			wanderClock = wanderTime
	var difference = target_location - position
	if difference.length() < 10 and not homeless:
		#fish_enter_sfx.play()
		visible = false
		set_process(false);#pause fish when they're not thinking
	position += difference.limit_length(speed * delta * $"/root/TurnManager".timespeed)
	flip_h = difference.x < 0
