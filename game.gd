extends Node

@onready var obj_hold := $ObjectHolder
@onready var curr_scene_hold := $CurrentScene
@onready var transition := $Transition

#@onready var loader := ResourceLoader

var curr_scene : Node

signal scene_spawned(scene: String)

enum SCENE_TRANSITION_TYPE {NORMAL, JUMP}


func _ready():
	RenderingServer.set_default_clear_color(Color.BLACK)
	change_scene("res://scenes/game/splash/splash.tscn")



func change_scene(scene: String, scene_data: Dictionary = {} ,trans := SCENE_TRANSITION_TYPE.NORMAL) -> void:
	match trans:
		SCENE_TRANSITION_TYPE.NORMAL:
			transition.transition("out")
			await transition.trans_anim_done
		SCENE_TRANSITION_TYPE.JUMP:
			# I mean yeah, of course you do nothing, it's a jump cut
			pass
	
	# load and spawn the scene
	var scn = load(scene).instantiate()
	scn.done.connect(handle_scene_done.bind())
	
	if curr_scene_hold.get_child_count() > 0:
		for child in curr_scene_hold.get_children():
			child.queue_free()
	
	curr_scene_hold.add_child(scn)
	curr_scene = scn
	print(scn)
	print(curr_scene)
	
	
	print("spawned")
	print(curr_scene)
	match trans:
		SCENE_TRANSITION_TYPE.NORMAL:
			transition.transition("in")
			await transition.trans_anim_done
		SCENE_TRANSITION_TYPE.JUMP:
			# I mean yeah, of course you do nothing, it's a jump cut
			pass
	
	curr_scene.start(scene_data)


func handle_scene_done(info: Dictionary) -> void:
	if info.has("transition"):
		change_scene(info.scene, info, info.transition)
	else:
		change_scene(info.scene, info)
