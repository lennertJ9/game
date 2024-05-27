extends Control
class_name ability_slot

@export var current_ability: Ability

@onready var ability_icon = $AbilityIcon


func _get_drag_data(at_position):
	if current_ability:
		return current_ability


func _ready():
	if current_ability:
		ability_icon.texture = current_ability.icon


func update_slot(ability: Ability):
	if ability:
		current_ability = ability
		ability_icon.texture = ability.icon



func _can_drop_data(at_position, data):
	if data is Ability:
		return true



func _drop_data(at_position, data):
	update_slot(data)
