extends NinePatchRect


@onready var slots = $AbilitySlots.get_children()
var abilities_array: Array[Ability]


func _ready():
	abilities_array.resize(6)
	var player = get_tree().get_first_node_in_group("player")
	for slot in slots:
		slot.drop.connect(player.ability_manager.set_ability)
		slot.drag.connect(on_drag)
		slot.drop.connect(on_drop)



func on_drag(data,index, slot: Control):
	abilities_array[index] = null
	slot.update_slot(null)


func on_drop(data,index, slot: Control):
	check(data)
	abilities_array[index] = data
	slot.update_slot(data)



func check(data: Ability):
	for slot in slots:
		if slot.current_ability:
			if slot.current_ability.name == data.name:
				slot.update_slot(null)


func _input(event):
	if event.is_action_pressed('debug'):
		print(abilities_array)
