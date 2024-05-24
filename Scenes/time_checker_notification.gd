extends Window

var can_close_window:bool = false
var notification_is_being_used := false
var current_text : String

func _on_main_call_time_checker_notification():
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
