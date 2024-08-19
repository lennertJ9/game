extends NinePatchRect


@onready var slots = $AbilitySlots.get_children()
var abilities_array: Array[Ability]


func _ready():
	var player = get_tree().get_first_node_in_group("player")
	for slot in slots:
		slot.drop.connect(player.ability_manager.set_ability)
		slot.drop.connect(on_drag)
		slot.drop.connect(on_drop)



func on_drag(data,index):
	abilities_array[index]


func on_drop(data,index):
	pass
