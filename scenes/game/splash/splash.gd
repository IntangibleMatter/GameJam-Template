extends GameScene

@onready var anim_player := $AnimationPlayer

#signal done(done_data: Dictionary)

# Called when the node enters the scene tree for the first time.
func _ready():
	print("yolo")

func start(_start_data: Dictionary):
	print("yeahhh!")
	anim_player.play("splash")
	print("wooo!")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "splash":
		emit_signal("done", {"scene": "res://scenes/game/ui/main_menu.tscn"})
