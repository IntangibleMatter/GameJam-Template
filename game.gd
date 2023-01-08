extends Node

@onready var obj_hold := $ObjectHolder
@onready var curr_scene_hold := $CurrentScene
@onready var transition := $Transition

var curr_scene : Node

signal scene_spawned(scene: String)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

enum SCENE_TRANSITION_TYPE {NORMAL, JUMP}

func change_scene(scene: String, trans := SCENE_TRANSITION_TYPE.NORMAL) -> void:
	match trans:
		SCENE_TRANSITION_TYPE.NORMAL:
			transition.transition("out")
			await transition.trans_anim_done
		SCENE_TRANSITION_TYPE.JUMP:
			# I mean yeah, of course you do nothing, it's a jump cut
			pass
	spawn_scene(scene)
	await scene_spawned
	match trans:
		SCENE_TRANSITION_TYPE.NORMAL:
			transition.transition("in")
			await transition.trans_anim_done
		SCENE_TRANSITION_TYPE.JUMP:
			# I mean yeah, of course you do nothing, it's a jump cut
			pass


func spawn_scene(scene: String) -> void:
	var scn = load(scene).instance()
	if scn.has_signal("done"):
		scn.done.connect(handle_scene_done.bind(scn.scn_done_data))
	
	if curr_scene_hold.get_child_count() > 0:
		for child in curr_scene_hold.get_children():
			child.queue_free()
	
	curr_scene_hold.add_child(scn)
	
	emit_signal("scene_spawned", scene)


func handle_scene_done(info: Dictionary) -> void:
	if info.has("transition"):
		change_scene(info.scene, info.transition)
	else:
		change_scene(info.scene)
