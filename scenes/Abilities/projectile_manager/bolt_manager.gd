extends Node2D


@export var bolt_instance: PackedScene
@export var png: CompressedTexture2D 

@export var cooldown: float
@export var off_cooldown: bool = true

@onready var cooldown_timer = $CooldownTimer


@export var boolie = true
@onready var attack_animations = $"../../AttackAnimations"


func shoot(shoot_direction,position):
	if off_cooldown:
		if owner.has_method("play_animation"):
			owner.play_animation()
		$"../../CanvasLayer/ResourceBar/Slots/Slot".timer(1)
		var bolt = bolt_instance.instantiate()
		var world = get_tree().get_first_node_in_group("world")
		bolt.global_position = position
		bolt.movement_direction = shoot_direction
		bolt.angle = rad_to_deg(shoot_direction.angle())
		world.add_child(bolt)
		
		off_cooldown = false
		cooldown_timer.start()
	else:
		print(cooldown_timer.time_left)


func _ready():
	cooldown_timer.wait_time = cooldown
	

func _on_cooldown_timer_timeout():
	off_cooldown = true



