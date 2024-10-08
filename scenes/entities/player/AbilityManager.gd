extends Node

signal ability_use


var ability_list:Array[String]
var boltresource = preload("res://resources/abilities/magic_bolt.tres")
var attack_ready: bool = true
@onready var attack_speed_timer = $AttackSpeedTimer





func _ready():
	var player_stats: Stats = preload("res://resources/stats/player_stats.tres")
	attack_speed_timer.wait_time = player_stats.attack_speed



func set_ability(ability: Ability, index):
	if ability:
		check(ability)
		var ui: UserInterface = get_tree().get_first_node_in_group("UI")
		var ability_manager = ability.manager.instantiate()
		add_child(ability_manager)
		ability_manager.name = str(ability.name)
		ability_manager.set_owner(owner)
		ability_manager.input = "slot_" + str(index + 1)
		ability_manager.ability_used.connect(ui.ability_bar.slots[index].start_cooldown)


func check(ability: Ability):
	var ui: UserInterface = get_tree().get_first_node_in_group("UI")
	for manager in get_children():
		if manager.name == ability.name:
			print("duplicate!!")
			remove_child(manager) # beide zijn nodig voor naming conflict te voorkomen
			manager.queue_free()
<<<<<<< Updated upstream:scenes/entities/player/AbilityManager.gd
			











func _on_attack_speed_timer_timeout():
	attack_ready = true
	
=======
>>>>>>> Stashed changes:scenes/abilities/ability_manager/AbilityManager.gd
