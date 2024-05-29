extends Window

var can_close_window:bool = false
var notification_is_being_used := false
var current_hour_minute : String
var current_text : String
var defaultCheckInfo := preload("res://Assets/Scenes/CheckInfo.tscn")

const TIME_CHECKS_PATH := "user://TimeChecks/"

#when calling this, send current time in hours and minutes
func _on_main_call_time_checker_notification():
	current_hour_minute = Time.get_time_string_from_system(false)
	current_hour_minute = current_hour_minute.erase(5,3)
	var current_time_text = "It's " + current_hour_minute + "!"
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
	var timeCheckerRes : TimeCheckerResource = TimeCheckerResource.new()
	timeCheckerRes.HHMM = current_hour_minute
	timeCheckerRes.text = new_text
	saveTimeCheckAsScene(timeCheckerRes)
	notification_is_being_used = false
	ResetNotificationWindow()
	hide()

func saveTimeCheckAsScene(timeCheckerRes : TimeCheckerResource):
	#can't save using ":" in the name.
	var newCheckInfo := defaultCheckInfo.instantiate()
	var reformatedHHMM := timeCheckerRes.HHMM.replace(":","-")
	var checkDate := Time.get_date_string_from_system() + "_" + reformatedHHMM
	var saveName := "Check_" + checkDate
	newCheckInfo.find_child("DayAndHour").text = checkDate
	newCheckInfo.find_child("CheckNote").text = timeCheckerRes.text
	var scene = PackedScene.new()
	scene.pack(newCheckInfo)
	var err = ResourceSaver.save(scene, TIME_CHECKS_PATH + saveName + ".tscn", ResourceSaver.FLAG_NONE)

func _on_button_pressed():
	if notification_is_being_used:
		_on_line_edit_text_submitted(current_text)

func ResetNotificationWindow():
	$HBoxContainer/VBoxContainer/WhatAmIDoingNote/LineEdit.text = ""
