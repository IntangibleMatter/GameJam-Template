extends Control

signal return_to_menu

func _on_back_button_pressed() -> void:
	emit_signal("return_to_menu")


func set_focus_self() -> void:
	$HBoxContainer/VBoxContainer/BackButton.grab_focus()

