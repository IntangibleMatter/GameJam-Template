extends GameScene

@onready var main_menu_button_container := $VBoxContainer/MainPanel/MenuDisplay/MenuDisplayOptionsContainer/MainMenuButtons
@onready var extra_menus := $VBoxContainer/MainPanel/MenuDisplay/MenuDisplayOptionsContainer/ExtraMenus
@onready var credits_menu := $VBoxContainer/MainPanel/MenuDisplay/MenuDisplayOptionsContainer/ExtraMenus/menu_credits
@onready var options_menu := $VBoxContainer/MainPanel/MenuDisplay/MenuDisplayOptionsContainer/ExtraMenus/options_menu_options 

@onready var menu_anim_player := $VBoxContainer/MainPanel/MenuDisplay/MenuDisplayOptionsContainer/AnimationPlayer


func _on_options_button_pressed():
	credits_menu.visible = false
	options_menu.visible = true
	menu_anim_player.play("DisplayExtraMenu")


func _on_credits_button_pressed():
	credits_menu.visible = true
	options_menu.visible = false
	menu_anim_player.play("DisplayExtraMenu")


func _on_menu_credits_return_to_menu():
	menu_anim_player.play("HideExtraMenu")


func _on_options_menu_options_return_to_menu():
	menu_anim_player.play("HideExtraMenu")
