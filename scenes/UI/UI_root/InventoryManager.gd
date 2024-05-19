extends Control


@onready var preview = $Preview
@onready var preview_texture = $Preview/PreviewTexture

var drag: bool



func _ready():
	set_physics_process(false)
	Resource.new()



func _physics_process(delta):
	preview.position = lerp(preview.position,get_global_mouse_position(), 15*delta)
	
	

func make_preview(texture: Texture2D):
	preview.position = get_global_mouse_position()
	drag = true
	preview_texture.texture = texture
	set_physics_process(true)


func _input(event):
	if event is InputEventMouseButton and drag:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			set_physics_process(false)
			preview_texture.texture = null
			drag = false


