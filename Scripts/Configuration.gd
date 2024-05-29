class_name Configuration
extends Node

signal new_node_saved

const TIME_CHECKS_PATH := "user://TimeChecks/"

func onApplicationStart():
	#check if ddirectories to save checks exists.
	if DirAccess.dir_exists_absolute(TIME_CHECKS_PATH):
		pass
	else:
		print("Creating checks directory")
		DirAccess.make_dir_absolute(TIME_CHECKS_PATH)


