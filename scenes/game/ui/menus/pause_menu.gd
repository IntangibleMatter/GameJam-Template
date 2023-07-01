extends GameScene

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var resume: Button = $PauseMenu/PauseMenu/Resume
@onready var options: Button = $PauseMenu/PauseMenu/Options
@onready var main_menu: Button = $PauseMenu/PauseMenu/MainMenu
@onready var options_menu_options: Control = $OptionsMenu/options_menu_options
@onready var game : Node = get_tree().current_scene

func _ready() -> void:
	resume.grab_focus()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause_game"):
		if game.is_in_group("game"):
			if game.curr_scene.is_in_group("nopause"):
				return
		if !visible:
			show_menu()
		else:
			hide_menu()


func show_menu() -> void:
	get_tree().paused = true
	resume.grab_focus()
	animation_player.play("pause")


func hide_menu() -> void:
	animation_player.play("unpause")
	await animation_player.animation_finished
	get_tree().paused = false


func _on_options_menu_options_return_to_menu() -> void:
	animation_player.play("hide_options")
	options.grab_focus()


func _on_options_pressed() -> void:
	animation_player.play("show_options")
	options_menu_options.set_focus_self()


func _on_resume_pressed() -> void:
	hide_menu()


func _on_main_menu_pressed() -> void:
	emit_signal("done", {"scene": "res://scenes/game/ui/menus/main_menu.tscn"})
	print("WEDIOFJFLS")
	hide_menu()
