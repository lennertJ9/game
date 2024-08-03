extends Node

signal ability_use

var boltresource = preload("res://resources/abilities/magic_bolt.tres")
var attack_ready: bool = true
@onready var attack_speed_timer = $AttackSpeedTimer


@onready var slot_1 = $Slot1
@onready var slot_2 = $Slot2
@onready var slot_3 = $Slot3
@onready var slot_4 = $Slot4
@onready var slot_5 = $Slot5
@onready var slot_6 = $Slot6


func _ready():
	var player_stats: Stats = preload("res://resources/stats/player_stats.tres")
	attack_speed_timer.wait_time = player_stats.attack_speed
	
	
	

func set_ability(ability: Ability, index):
	if ability:
		
		remove_manager(null, index)
		
		var ability_manager = ability.manager.instantiate()
		ability_manager.ability_resource = ability
		ability_manager.ability_scene = ability.ability_scene
		ability_manager.current_index = index
		var slot_node = get_child(index)
		slot_node.add_child(ability_manager)
		slot_node.get_child(0).ability_use.connect(ability_used)



func ability_used(ability: Ability, index: int):
	ability_use.emit(ability,index)
	



func remove_manager(ability: Ability,index): # verwijderd de manager van een bepaalde slot (index)
	if get_child(index).get_child_count() > 0:
		get_child(index).get_child(0).queue_free()



func _input(event):
	if attack_ready:
		
		
		
		if event.is_action_pressed("slot_1") and slot_1.get_child(0):
			attack_ready = false
			attack_speed_timer.start()
			slot_1.get_child(0).use()
		
		if event.is_action_pressed("slot_2") and slot_2.get_child(0):
			attack_ready = false
			attack_speed_timer.start()
			slot_2.get_child(0).use()
			
		if event.is_action_pressed("slot_3") and slot_3.get_child(0):
			attack_ready = false
			attack_speed_timer.start()
			slot_3.get_child(0).use()
		
		if event.is_action_pressed("slot_4") and slot_4.get_child(0):
			attack_ready = false
			attack_speed_timer.start()
			slot_4.get_child(0).use()
		
		if event.is_action_pressed("slot_5") and slot_5.get_child(0):
			attack_ready = false
			attack_speed_timer.start()
			slot_5.get_child(0).use()
		
		if event.is_action_pressed("slot_6") and slot_6.get_child(0):
			attack_ready = false
			attack_speed_timer.start()
			slot_6.get_child(0).use()




func _on_attack_speed_timer_timeout():
	attack_ready = true
	
