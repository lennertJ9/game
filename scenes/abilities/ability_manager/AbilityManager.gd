extends Node


var ability_list:Array[String]
var attack_ready: bool = true
@onready var attack_speed_timer = $AttackSpeedTimer





func _ready():
	var player_stats: Stats = preload("res://resources/stats/player_stats.tres")
	attack_speed_timer.wait_time = player_stats.attack_speed



func set_ability(ability: Ability, index, slot:Control):
	print("set ability: ", ability, " on slot index", index)
	if ability:
		check(ability)
		var ui: UserInterface = get_tree().get_first_node_in_group("UI")
		var ability_manager = ability.manager.instantiate()
		add_child(ability_manager)
		ability_manager.name = str(ability.name)
		ability_manager.set_owner(owner)
		ability_manager.input = "slot_" + str(index + 1)
		ability_manager.ability_used.connect(ui.ability_bar.slots[index].start_cooldown)



func check(ability: Ability): #checken voor duplicates
	var ui: UserInterface = get_tree().get_first_node_in_group("UI")
	for manager in get_children():
		if manager.name == ability.name:
			remove_child(manager) # beide zijn nodig voor naming conflict te voorkomen
			manager.queue_free()



