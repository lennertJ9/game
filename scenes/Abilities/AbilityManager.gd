extends Node2D

signal ability_used

@onready var cooldown_timer = $Cooldown

@export var ability_resource : Ability
var off_cooldown : bool
var index : int

func _ready():
	off_cooldown = true
	if ability_resource:
		ability_resource.ability_scene.speed = 30


func use_ability():
	if ability_resource and off_cooldown:
		
		#cooldown_timer.wait_time = ability_resource.cooldown   idk als dit nodig is
		cooldown_timer.start()
		off_cooldown = false
		
		get_parent().shoot(global_position.direction_to(get_global_mouse_position()),global_position, ability_resource)
		ability_used.emit(get_index())


func update_ability_manager(resource : Ability):
	if resource:
		ability_resource = resource
		off_cooldown = false
		cooldown_timer.wait_time = ability_resource.cooldown
		cooldown_timer.start()
	else:
		ability_resource = null
	
	

func _on_cooldown_timeout():
	off_cooldown = true
