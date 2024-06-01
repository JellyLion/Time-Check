class_name Configuration
extends Node

var default_settings := preload("res://Assets/Scenes/default_settings_save.tscn")
@onready var Main := $".."
@onready var time_to_call_notification_spin_box = $"../VBoxContainer/HBoxContainer/MarginContainer/DefaultSpace/TimeToCallNotificationContainer/TimeToCallNotification"
@onready var startOnCurrentTimeCheckButton = $"../VBoxContainer/HBoxContainer/MarginContainer/DefaultSpace/StartOnCurrentTime/StartOnCurrentTimeCheckButton"

signal new_node_saved

const TIME_CHECKS_PATH := "user://TimeChecks/"
const SETTINGS_PATH := "user://Settings/"

func onApplicationStart():
	#check if directiories exist, if not, create them
	if DirAccess.dir_exists_absolute(TIME_CHECKS_PATH):
		pass
	else:
		print("Creating checks directory")
		DirAccess.make_dir_absolute(TIME_CHECKS_PATH)
	if DirAccess.dir_exists_absolute(SETTINGS_PATH):
		var files_at_path = DirAccess.get_files_at(SETTINGS_PATH)
		if("".join(files_at_path) != ""):
			print("loading stored settings")
			load_stored_settings()
		else:
			print("using default settings")
			use_default_settings()
	else:
		print("Creating settings directory")
		DirAccess.make_dir_absolute(SETTINGS_PATH)
		use_default_settings()

func load_stored_settings():
	var current_settings_file = DirAccess.get_files_at(SETTINGS_PATH)
	current_settings_file = current_settings_file[0]
	var settings_to_packed_scene : PackedScene = load(SETTINGS_PATH + current_settings_file)
	var loaded_settings_node = settings_to_packed_scene.instantiate()
	loaded_settings_node.name = "settings"
	add_child(loaded_settings_node,false)
	time_to_call_notification_spin_box.value = int($"settings/minutes_to_call_notification".text)
	startOnCurrentTimeCheckButton.button_pressed =  bool(int($"settings/start_at_current_time".text))

func use_default_settings():
	time_to_call_notification_spin_box.value = int($"default_settings/minutes_to_call_notification".text)
	print (Main.minutes_to_call_notification)
	startOnCurrentTimeCheckButton.button_pressed =  bool(int($"default_settings/start_at_current_time".text))
	print(str(Main.start_at_current_time))
	save_current_settings(true)
	load_stored_settings()

func save_current_settings(is_default_settings := false):
	var node_to_save
	if(is_default_settings):
		node_to_save = $default_settings
	else:
		node_to_save = $settings
	var settings_ps = PackedScene.new()
	settings_ps.pack(node_to_save)
	var err = ResourceSaver.save(settings_ps, SETTINGS_PATH + "settings.tscn", ResourceSaver.FLAG_NONE)

func _on_time_to_call_notification_value_changed(value):
	$settings/minutes_to_call_notification.text = str(value)
	save_current_settings()


func _on_start_on_current_time_check_button_toggled(toggled_on):
	$settings/start_at_current_time.text = str(toggled_on)
	print ($settings/start_at_current_time.text)
	save_current_settings()
