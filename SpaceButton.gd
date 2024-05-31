extends TextureButton

signal _on_view_button_pressed(which : String)

@export var which :String

func _on_pressed():
	_on_view_button_pressed.emit(which)
