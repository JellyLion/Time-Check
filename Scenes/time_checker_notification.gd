extends Window

var can_close_window:bool = false

func _on_main_call_time_checker_notification():
	show()
	can_close_window = true
	await get_tree().create_timer(5.0).timeout
	can_close_window = false
	hide_window_by_timeout()
	
func on_button_pressed():
	if can_close_window:
		hide()

func hide_window_by_timeout():
	hide()

