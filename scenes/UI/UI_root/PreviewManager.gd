extends TextureRect

var drag = false

func make_preview(preview_texture: Texture2D):
	print("make preview")
	global_position = get_global_mouse_position()
	texture = preview_texture
	drag = true
	set_physics_process(true)


func _physics_process(delta):
	global_position = lerp(global_position,get_global_mouse_position() - Vector2(40,40), 20 * delta)


func _input(event):
	if event is InputEventMouseButton and drag:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			set_physics_process(false)
			texture = null
			drag = false


