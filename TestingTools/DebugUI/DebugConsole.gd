extends CanvasLayer
#debug bar
# a command-word cannot include spaces
# to add a command, add the command-word to the commandMap, then give it the function you would like to call
# the command "output" will be shown in the debug history

#every command in this map should return a string
var commandMap = {
	"setZoom" : set_Zoom, 
	"setSpeed" : set_speed,
	"endless" : set_endless,
	"explode" : clear_level,
	"giveItem" : give_item,
}

func give_item(item_id:String, amount="1"):
	if !int(amount):
		return "invalid argument " + amount
	InventoryManager.addItems(int(item_id), int(amount))
	return "gave " + amount + " items"

func clear_level():
	$/root/MainLevel/Tilemaps/Breakables.clear()
	return "set"

var is_endless = false
func set_endless():
	is_endless = !is_endless
	return "set endless mode" + str(is_endless)
		
func set_speed(speedScale:String):
	if float(speedScale):
		TurnManager.timespeed = float(speedScale)
		return "set"
	else:
		return "invalid argument " + speedScale

func set_Zoom(zoomScale:String):
	if float(zoomScale):
		$/root/MainLevel/Camera2D.zoom = Vector2(float(zoomScale), float(zoomScale))
		return "set"
	else:
		return "invalid argument " + zoomScale

const upperStrFmt = "
fps: {fps}
fpsAvg: {fpsAvg}
fpsMin: {fpsMin}
turnTimer: {turnTimer}
"
const lowerStrFmt = "
fishSeed: {fishSeed}
"

const fpsAvgCount = 5
var fpsMin = 10000
var fpsRecord = [0, 0, 0, 0, 0]
var fpsCursor = 0
func _process(delta): #manage the text UI
	#--endless mode--
	if (is_endless):
		#note: this will cause a lot off extra orphaned fish entities
		# so this isn't fit for a real feature
		FishManager.homelessFish = {
			0:[],
			1:[],
			2:[],
		}
	#--fps calulcation--
	var fps = Engine.get_frames_per_second()
	if fps < fpsMin && fps != 1:
		fpsMin = fps
	fpsRecord[fpsCursor] = fps
	fpsCursor = (fpsCursor+1) %fpsAvgCount
	var fpsAvg = fpsRecord.reduce(func(a,x): return a+x, 0) / fpsAvgCount
	#--set text--
	$upperStr.text = upperStrFmt.format({
		"fps": fps,
		"fpsAvg": fpsAvg,
		"fpsMin": fpsMin,
		"turnTimer": TurnManager.roundTimer
		})
	$lowerStr.text = lowerStrFmt.format({
		"fishSeed": FishManager.fishRNG.seed,
		})

# === The bellow functions should be able to function no matter what the above debug stuff is ==

#var command_history = []
func _input(event):
	if (event.is_echo() || !event.is_pressed()):
		return
	if Input.is_action_just_pressed('debug'):
		DebugConsole.visible = !DebugConsole.visible

#command handler
func _on_text_edit_lines_edited_from(from_line, to_line):
	if to_line != 0:
		var response = $Base/TextEdit.text.rstrip("\n ")
		if !response:
			$Base/TextEdit.clear()
			return
#		command_history.append(response)
		var input = response.split(" ",false)
		response += " > "
		if input[0] in commandMap:
			var output = commandMap[input[0]].callv(input.slice(1))
			if output:
				response += output
			else:
				response += "command input error"
		else:
			response += "command not found"
		response += '\n'
		$Base/TextEdit.clear()
		$Base/TextDisplay.text += (response)
#		$Base/TextDisplay.scroll_to_line($Base/TextDisplay.get_line_count())
		#print($Base/TextDisplay.get_line_count())
