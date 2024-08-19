extends Control


@onready var slots = $GridContainer.get_children()
var is_ability_menu_open = false


func _ready():
	visible = false



func open():
	if is_ability_menu_open:
		visible = false
		is_ability_menu_open = false
	else:
		visible = true
		is_ability_menu_open = true



