extends Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = Time.get_time_string_from_system(false)
	
