extends Control

signal return_to_menu

func _on_back_button_pressed():
	emit_signal("return_to_menu")
