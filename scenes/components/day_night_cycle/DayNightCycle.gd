extends CanvasModulate

const MINUTES_PER_DAY = 1440
const MINUTES_PER_HOUR = 60
const INGAME_TO_REAL_MINUTE_DURATION = (2*PI) / MINUTES_PER_DAY

signal time_tick(day: int, hour: int, minute:int) 

@export var gradient_sample: GradientTexture1D 
@export var ingame_speed = 1.0

var time: float = 0.0
var past_minute: float = -1.0

func _ready():
	color = gradient_sample.gradient.sample(0.0)


func _process(delta):
	time += delta * INGAME_TO_REAL_MINUTE_DURATION * ingame_speed
	var value = (sin(time - PI / 2) + 1.0) / 2.0
	color = gradient_sample.gradient.sample(value)
	
	



#func recalculate_time():
	#var total_minutes = int(time / INGAME_TO_REAL_MINUTE_DURATION)
	#var day = int(total_minutes / MINUTES_PER_DAY)
	#var current_day_minutes = total_minutes % MINUTES_PER_DAY
	#var hour = int(current_day_minutes / MINUTES_PER_HOUR)
	#var minute = int(current_day_minutes % MINUTES_PER_HOUR)
	#
	#if past_minute != minute:
		#time_tick.emit(day ,hour, minute)
