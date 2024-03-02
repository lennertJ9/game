extends Node2D

signal ability_used

@onready var cooldown_timer = $Cooldown

@export var resource : Resource
var off_cooldown : bool


func _ready():
	off_cooldown = true
	if resource:
		resource.ability_scene.speed = 30

func use_ability():
	if resource and off_cooldown:
		
		cooldown_timer.wait_time = resource.cooldown
		cooldown_timer.start()
		off_cooldown = false
		
		get_parent().shoot(global_position.direction_to(get_global_mouse_position()),global_position, resource)


func _on_cooldown_timeout():
	off_cooldown = true
