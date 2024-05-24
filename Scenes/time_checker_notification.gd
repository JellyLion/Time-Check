extends Window

var can_close_window:bool = false
var notification_is_being_used := false
var current_text : String

#when calling this, send current time in hours and minutes
func _on_main_call_time_checker_notification():
	var current_time_text :String = Time.get_time_string_from_system(false)
	current_time_text = current_time_text.erase(5,3)
	print(current_time_text)
	current_time_text = "It's " + current_time_text + "!"
	$HBoxContainer/VBoxContainer/CurrentTimeHContainer/CurrentTimeLabel.text = current_time_text
	show()
	await get_tree().create_timer(5.0).timeout
	if not notification_is_being_used:
		hide()

func _on_line_edit_text_changed(new_text):
	#avoid closing notification window
	notification_is_being_used = true
	current_text = new_text

func _on_line_edit_text_submitted(new_text):
	#close notification and save the text.
	notification_is_being_used = false
	print("note submitted")	
	hide()

func _on_button_pressed():
	if notification_is_being_used:
		_on_line_edit_text_submitted(current_text)
