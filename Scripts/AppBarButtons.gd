extends HBoxContainer


func _on_minimize_pressed():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MINIMIZED,0)


func _on_maximize_pressed():
	print_debug("Not yet implemented")


func _on_close_pressed():
	get_tree().quit(0)
