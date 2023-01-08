extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

enum SCENE_TRANSITION_TYPE {NORMAL, JUMP}

func change_scene(scene: String, transition := SCENE_TRANSITION_TYPE.NORMAL) -> void:
	pass


func spawn_scene(scene: String) -> void:
	var scn = load(scene).instance()
	if scn.has_signal("done"):
		scn.done.connect(handle_scene_done.bind(scn.scn_done_data))


func handle_scene_done(info: Dictionary) -> void:
	if info.has("transition"):
		change_scene(info.scene, info.transition)
	else:
		change_scene(info.scene)
