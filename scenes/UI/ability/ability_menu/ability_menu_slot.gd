extends ability_slot
class_name ability_menu_slot


#func _ready():
	#pass

func _get_drag_data(at_position):
	if current_ability:
		drag.emit(current_ability, get_index())
		get_tree().get_first_node_in_group("UI").preview_manager.make_preview(current_ability.icon)
		return current_ability



func _can_drop_data(at_position, data):
	return false



func start_cooldown(time: float): # deze functie is niet nodig, daarom pass
	pass



func _input(event):
	pass
