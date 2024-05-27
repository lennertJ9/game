extends ability_slot
class_name ability_menu_slot




func _get_drag_data(at_position):
	if current_ability:
		drag.emit(current_ability.icon)
		return current_ability


func _can_drop_data(at_position, data):
	return false

