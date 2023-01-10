extends GameScene

@onready var anim_player := $AnimationPlayer


func start(_start_data: Dictionary):
	$ParallaxBackground/sml/SmallStarParallax.seek(randf_range(0, 20))
	$ParallaxBackground/med/MedStarParallax.seek(randf_range(0,15))
	$ParallaxBackground/big/BigStarParallax.seek(randf_range(0,10))
	anim_player.play("splash")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "splash":
		emit_signal("done", {"scene": "res://scenes/game/ui/menus/main_menu.tscn"})
