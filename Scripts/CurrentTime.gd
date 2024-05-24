extends Label

var current_time:String
var minute_at_current_delta: int
var current_minute: int

signal minute_changed(current_minute :int)

func _process(delta):
	current_time = Time.get_time_string_from_system(false)
	text = current_time
	#current time string is formated like this: HH:MM:SS
	minute_at_current_delta = int(text.get_slice(":", 1))
	#we will need to operate on hours to, so instead of ending at 59, the minutes
	#should end at 60 and start at 1
	if minute_at_current_delta == 0:
		minute_at_current_delta = 60
	if current_minute != minute_at_current_delta:
		current_minute = minute_at_current_delta
		emit_signal("minute_changed", current_minute)
