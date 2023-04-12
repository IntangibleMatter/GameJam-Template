extends GameScene

@export_file("*.txt") var storybook_file := "res://scenes/game/storybook/storybook.txt"
@export_file("*.tscn") var first_game_scene

@onready var book_images := $BookImages
@onready var book_text = $BookText
@onready var next_button := $NextButton
@onready var back_button = $BackButton

var storybook_text: Array[String]
var storybook_pages: Array[Texture2D]
var storybook_index : int = 0

@onready var game_width : int = ProjectSettings.get_setting("display/window/size/viewport_width")

func _ready() -> void:
	set_move_buttons()
	next_button.grab_focus()
	load_storybook()

func load_storybook() -> void:
	var f = FileAccess.open(storybook_file, FileAccess.READ)
	
	while not f.eof_reached():
		storybook_text.append(f.get_line())
	
	
	for i in range(storybook_text.size() - 1):
		var img := "res://assets/graphics/storybook/%d.png" % i
		print(img)
		if FileAccess.file_exists(img):
			storybook_pages.append(load(img))
	
	book_images.custom_minimum_size.x = game_width * storybook_pages.size()
	book_images.position = Vector2.ZERO
	for i in range(storybook_pages.size()):
		var trect := TextureRect.new()
		trect.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		trect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		trect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		trect.texture = storybook_pages[i]
		book_images.add_child(trect)
	
	display_current_storybook_page()


func display_current_storybook_page() -> void:
	if storybook_pages.size() < storybook_index or storybook_text.size() < storybook_index:
		return
#	book_image.texture = storybook_pages[storybook_index] 
	next_button.disabled = true
	back_button.disabled = true
	var tween : Tween = get_tree().create_tween()\
	.set_ease(Tween.EASE_IN_OUT)\
	.set_trans(Tween.TRANS_CUBIC)\
	.set_parallel(true)
	book_text.visible_ratio = 0
	book_text.text = "[center]%s" % storybook_text[storybook_index]
	tween.tween_property(book_images,
	"position",
	Vector2(storybook_index * -game_width, 0),
	0.7
	)
	tween.tween_property(book_text, "visible_ratio", 1, 0.7)
	await tween.finished
	set_move_buttons()


func set_move_buttons() -> void:
	next_button.disabled = false
	if storybook_index == 0:
		back_button.disabled = true
	else:
		back_button.disabled = false
	if storybook_index == storybook_pages.size() - 1:
		next_button.text = "Done"
	else:
		next_button.text = "Next"

func _on_next_button_pressed() -> void:
	storybook_index += 1
	if storybook_index < storybook_text.size() - 1:
		display_current_storybook_page()
	else:
		emit_signal("done", {"scene": first_game_scene})


func _on_back_button_pressed():
	storybook_index -= 1
	if storybook_index >= 0:
		display_current_storybook_page()
