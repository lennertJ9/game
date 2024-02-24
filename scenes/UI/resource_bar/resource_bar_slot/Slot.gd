extends Control

@onready var ability_texture = $AbilityTexture
@onready var slot_texture = $SlotTexture


func set_icon(png):
	ability_texture.texture = png
