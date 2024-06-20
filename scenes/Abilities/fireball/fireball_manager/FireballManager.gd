extends Node2D

signal ability_use

@export var ability_scene: PackedScene
@export var ability_resource: Ability

@onready var ability_cooldown = $AbilityCooldown

var is_off_cooldown: bool = false
var input_slot = "slot_1"
var current_index


func _ready():
	start_cooldown()



func use(): # checkt voor cooldown, add de ability als child, in de wereld
	if ability_resource.is_ready:
		ability_use.emit(ability_resource, current_index)
		start_cooldown()
		var ability = make_ability()
		add_child(ability)



func make_ability() -> Node2D: # maakt de ability klaar om in de wereld gezet te worden, zet de proporties
	print("make, ability resourcce -->", ability_resource)
	var ability = ability_scene.instantiate()
	ability.damage = ability_resource.damage
	ability.speed = ability_resource.speed
	ability.global_position = get_tree().get_first_node_in_group("player").global_position
	ability.movement_direction = get_tree().get_first_node_in_group("player").global_position.direction_to(get_global_mouse_position())
	return ability



func start_cooldown():
	ability_resource.is_ready = false
	ability_cooldown.wait_time = ability_resource.cooldown
	ability_cooldown.start()


func _on_ability_cooldown_timeout():
	ability_resource.is_ready = true




