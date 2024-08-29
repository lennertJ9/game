extends Node2D

signal ability_used


@export var ability_scene: PackedScene

@onready var ability_cooldown = $AbilityCooldown

var is_ready: bool = false
var cooldown: float = 0.5
var input: String 

var explosion_damage_ratio: float = 1.5
var trail_damage_ratio: float = 0.5
var player_damage: int



func _ready():
	player_damage = get_tree().get_first_node_in_group("player").stats.damage
	ability_cooldown.wait_time = cooldown
	await get_tree().physics_frame
	
	ability_used.emit(cooldown) # ui timer starten
	ability_cooldown.start()


func _input(event):
	if event.is_action_pressed(input) and is_ready:
		is_ready = false
		use()
		ability_used.emit(cooldown)



func use():
	player_damage = get_tree().get_first_node_in_group("player").stats.damage
	ability_cooldown.start()
	
	var ability = ability_scene.instantiate()
	ability.global_position = owner.global_position
	ability.direction = ability.position.direction_to(get_global_mouse_position())
	ability.explosion_pos = get_global_mouse_position()
	ability.rotation_degrees = rad_to_deg(ability.direction.angle())
	
	ability.explosion_damage = player_damage * explosion_damage_ratio
	ability.trail_damage = player_damage * trail_damage_ratio
	add_child(ability)




func _on_ability_cooldown_timeout():
	is_ready = true
