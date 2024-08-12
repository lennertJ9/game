extends Node2D

signal ability_used


@export var ability_scene: PackedScene
var cooldown: float = 2.0
var input: String 

var explosion_damage_ratio: float = 1.5
var trail_damage_ratio: float = 0.5
var player_damage: int


func _ready():
	player_damage = get_tree().get_first_node_in_group("player").stats.damage


func _input(event):
	if event.is_action_pressed(input):
		use()
		ability_used.emit(2.0)
		


func use():
	player_damage = get_tree().get_first_node_in_group("player").stats.damage
	
	var ability = ability_scene.instantiate()
	ability.global_position = owner.global_position
	ability.direction = ability.position.direction_to(get_global_mouse_position())
	ability.explosion_pos = get_global_mouse_position()
	ability.rotation_degrees = rad_to_deg(ability.direction.angle())
	
	ability.explosion_damage = player_damage * explosion_damage_ratio
	ability.trail_damage = player_damage * trail_damage_ratio
	add_child(ability)
	


