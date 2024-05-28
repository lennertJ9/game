extends Node2D

@export var ability_scene: PackedScene
@export var ability_resource: Ability

@onready var ability_cooldown = $AbilityCooldown

var is_off_cooldown: bool = false
var input_slot = "slot_1"


func _ready():
	start_cooldown()


func use(): # checkt voor cooldown, add de ability als child, in de wereld
	if is_off_cooldown:
		start_cooldown()
		var ability = make_ability()
		add_child(ability)



func make_ability() -> Node2D: # maakt de ability klaar om in de wereld gezet te worden, zet de proporties
	var ability = ability_scene.instantiate()
	ability.damage = 1
	ability.speed = 20
	ability.global_position = get_tree().get_first_node_in_group("player").global_position
	ability.movement_direction = get_tree().get_first_node_in_group("player").global_position.direction_to(get_global_mouse_position())
	return ability



func start_cooldown():
	is_off_cooldown = false
	ability_cooldown.wait_time = ability_resource.cooldown
	ability_cooldown.start()


func _on_ability_cooldown_timeout():
	is_off_cooldown = true


func _input(event):
	if event.is_action_pressed(input_slot):
		print("presssss21s")
