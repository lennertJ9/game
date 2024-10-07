extends Control


@onready var slots = $GridContainer.get_children()


func open():
	visible = true


func close():
	visible = false
<<<<<<< Updated upstream
=======



func open() -> void:
	if is_ability_menu_open:
		visible = false
		is_ability_menu_open = false
	else:
		visible = true
		is_ability_menu_open = true
>>>>>>> Stashed changes
