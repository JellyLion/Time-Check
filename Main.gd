extends Control

var minutes_to_call_notification := 1
var current_minute : int
var start_at_current_time := false
var minutes_past_starting_minute : int

signal call_time_checker_notification

func _ready():
	Configuration.onApplicationStart()

func _on_current_time_minute_changed(minute):
	current_minute = minute
	if not start_at_current_time:
		if current_minute % minutes_to_call_notification == 0:
			emit_signal("call_time_checker_notification")
	else:
		minutes_past_starting_minute += 1
		if minutes_past_starting_minute == 61:
			minutes_past_starting_minute = 1
		if minutes_past_starting_minute % minutes_to_call_notification == 0:
			emit_signal(("call_time_checker_notification"))

func _on_spin_box_value_changed(value):
	print("spin box value changed " + str(value))
	minutes_to_call_notification = value
	#also reset minutes past time notification.
	minutes_past_starting_minute = 0


func _on_check_button_toggled(toggled_on):
	print("button toggled, value: " + str(toggled_on))
	start_at_current_time = toggled_on
	if toggled_on:
		minutes_past_starting_minute = 0
