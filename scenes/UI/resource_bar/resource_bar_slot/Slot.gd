extends Control

@onready var icon_progress_bar = $TextureProgressBar
@onready var slot_texture = $SlotTexture


func set_icon(png):
	icon_progress_bar.texture_progress = png
	icon_progress_bar.texture_under = png


func _ready():
	pass
