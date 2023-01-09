extends CanvasLayer

@onready var anim_player := $AnimationPlayer

signal trans_anim_done

func _ready():
	anim_player.play("RESET")


func transition(dir: String) -> void:
	print("transitioning %s"%dir)
	match dir:
		"in":
			anim_player.play("trans_in")
		"out":
			anim_player.play("trans_out")
	await anim_player.animation_finished
	emit_signal("trans_anim_done")
