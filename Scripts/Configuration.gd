class_name Configuration
extends Node

const TIME_CHECKS_PATH := "user://TimeChecks/"

static func saveTimeCheck(timeCheckerRes : TimeCheckerResource):
	#can't save using ":" in the name.
	var reformatedHHMM := timeCheckerRes.HHMM.replace(":","-")
	var saveName := "Check_" + Time.get_date_string_from_system() + "_" + reformatedHHMM
	timeCheckerRes.resource_name = saveName
	var err = ResourceSaver.save(timeCheckerRes, TIME_CHECKS_PATH + saveName + ".tres", ResourceSaver.FLAG_NONE)
	print("Check saved: " + str(err))	

static func onApplicationStart():
	#check if ddirectories to save checks exists.
	if DirAccess.dir_exists_absolute(TIME_CHECKS_PATH):
		pass
	else:
		print("Creating checks directory")
		DirAccess.make_dir_absolute(TIME_CHECKS_PATH)
