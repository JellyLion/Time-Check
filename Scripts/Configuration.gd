class_name Configuration
extends Node

const TIME_CHECKS_PATH := "user://TimeChecks/"

static func saveTimeCheck(timeCheckerRes : TimeCheckerResource):
	var err = ResourceSaver.save(timeCheckerRes, TIME_CHECKS_PATH + "one" + ".tres", ResourceSaver.FLAG_NONE)
	print("note saved: " + str(err))	
