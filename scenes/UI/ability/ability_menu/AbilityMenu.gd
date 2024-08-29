extends Control


@onready var slots: Array[Node] = $GridContainer.get_children()
var is_ability_menu_open: bool = false


func _ready() -> void:
	visible = false



func open() -> void:
	if is_ability_menu_open:
		visible = false
		is_ability_menu_open = false
	else:
		visible = true
		is_ability_menu_open = true



