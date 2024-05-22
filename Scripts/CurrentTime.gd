extends Label

var minutes_to_call_notification:int = 1
var current_time:String
var current_minute: int
var last_minute: int

signal call_time_checker_notification

func _ready():
	last_minute = 60
	print(last_minute)

func _process(delta):
	current_time = Time.get_time_string_from_system(false)
	text = current_time
	#current time string is formated like this: HH:MM:SS
	var get_minutes = PackedStringArray([current_time[3],current_time[4]])
	current_minute = int("".join(get_minutes))
	#we will need to operate on hours to, so instead of ending at 59, the minutes
	#should end at 60 and start at 1
	if current_minute == 0:
		current_minute = 60
	if last_minute != current_minute:
		last_minute = current_minute
		_on_minute_changed()

func _on_minute_changed():
	#use % to see if a notification should be going on at this minute
	if last_minute % minutes_to_call_notification == 0:
		emit_signal("call_time_checker_notification")
