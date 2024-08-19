extends Control


var preview: TextureRect
var is_dragging = false



func _ready():
	set_process(false)



func _process(delta):
	global_position = get_global_mouse_position()



func make_preview(texture: Texture2D):
	is_dragging = true
	preview = TextureRect.new()
	preview.mouse_filter = Control.MOUSE_FILTER_IGNORE
	preview.position -= Vector2(40,40)
	preview.scale = Vector2(5,5)
	preview.texture = texture
	add_child(preview)
	set_process(true)



func _input(event):
	if event is InputEventMouseButton and is_dragging:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			is_dragging = false
			set_process(false)
			remove_child(preview)
			preview.queue_free()
