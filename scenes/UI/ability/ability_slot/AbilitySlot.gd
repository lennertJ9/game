extends Control
class_name ability_slot


signal drag
signal drop

@export var current_ability: Ability

@onready var ability_icon = $AbilityIcon


func _get_drag_data(at_position):
	if current_ability:
		drag.emit(current_ability.icon)
		var data = current_ability
		update_slot(null)
		return data


func _ready():
	if current_ability:
		ability_icon.texture = current_ability.icon


func update_slot(ability: Ability):
	if ability:
		current_ability = ability
		ability_icon.texture = ability.icon
	else:
		current_ability = null
		ability_icon.texture = null



func _can_drop_data(at_position, data):
	if data is Ability:
		return true



func _drop_data(at_position, data):
	update_slot(data)
	drop.emit(data, get_index())
	
