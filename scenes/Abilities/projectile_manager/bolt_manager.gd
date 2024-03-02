extends Node2D


@export var bolt_instance: PackedScene
@export var png: CompressedTexture2D 

@export var cooldown: float
@export var off_cooldown: bool = true

@onready var cooldown_timer = $CooldownTimer


@export var boolie = true
@onready var attack_animations = $"../../AttackAnimations"
@onready var slots = $"../CanvasLayer/ResourceBar/Slots"

func _ready():
	update_slots()
	
	
func update_slots():
	var slots = get_tree().get_first_node_in_group("UI").ability_slots.get_children()
	
	var i = 0
	for slot in slots:
		get_child(i).update_ability_manager(slot.resource)
		i += 1
	
	
func shoot(shoot_direction,position,resource):
	if off_cooldown:
		if owner.has_method("play_animation"):
			owner.play_animation()
		
		
		var bolt = resource.ability_scene.instantiate()
		var world = get_tree().get_first_node_in_group("world")
		bolt.global_position = position
		bolt.movement_direction = shoot_direction
		bolt.angle = rad_to_deg(shoot_direction.angle())
		bolt.speed = resource.speed
		
		world.add_child(bolt)
		
		#off_cooldown = false
		
	else:
		print(cooldown_timer.time_left)

func test():
	print("test")

	





