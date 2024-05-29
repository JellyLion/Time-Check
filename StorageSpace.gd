extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	loadStoredChecks()


func loadStoredChecks():
	var filesArray := DirAccess.get_files_at(Configuration.TIME_CHECKS_PATH)
	for file in filesArray:
		var fileData := load(Configuration.TIME_CHECKS_PATH + file.get_file())
		var loadedNode = fileData.instantiate()
		$ScrollContainer/StoredChecksSpace.add_child(loadedNode, false)

func _on_new_note_saved():
	print_debug("not implemented")
