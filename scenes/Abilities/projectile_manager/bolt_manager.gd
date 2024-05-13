extends Node2D


@export var off_cooldown: bool = true


func _ready():
	update_slots()
	
	
func update_slots():
	var slots = get_tree().get_first_node_in_group("UI").resource_bar.slots.get_children()
	
	var i = 0
	for slot in slots:
		get_child(i).update_ability_manager(slot.resource)
		i += 1
	
	
func shoot(shoot_direction,position,resource):
	if owner.has_method("play_animation"):
		owner.play_animation()
	
	var bolt = resource.ability_scene.instantiate()
	var world = get_tree().get_first_node_in_group("world")
	bolt.global_position = position
	bolt.movement_direction = shoot_direction
	bolt.angle = rad_to_deg(shoot_direction.angle())
	bolt.speed = resource.speed
	
	world.add_child(bolt)






