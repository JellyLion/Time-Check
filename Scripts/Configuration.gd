class_name Configuration
extends Node

signal new_node_saved

const TIME_CHECKS_PATH := "user://TimeChecks/"
var defaultCheckInfo := preload("res://Assets/Scenes/CheckInfo.tscn")

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

func onApplicationStart():
	#check if ddirectories to save checks exists.
	if DirAccess.dir_exists_absolute(TIME_CHECKS_PATH):
		pass
	else:
		print("Creating checks directory")
		DirAccess.make_dir_absolute(TIME_CHECKS_PATH)


