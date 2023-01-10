extends Node

var save_data_path := "user://save.ini"

var savedata : Dictionary = {}

func _ready() -> void:
	load_game()

func save_game() -> void:
	var config := ConfigFile.new()
	

func load_game() -> void:
	var config := ConfigFile.new()
	if config.load(save_data_path) != OK:
		save_game()
	for key in config.get_section_keys("save"):
		savedata[key] = config.get_value("save", key)

