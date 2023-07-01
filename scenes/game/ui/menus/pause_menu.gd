extends GameScene

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause_game"):
		if !visible:
			show_menu()
		else:
			hide_menu()


func show_menu() -> void:
	pass


func hide_menu() -> void:
	pass
