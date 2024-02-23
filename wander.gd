extends Node


func _ready():
	
	set_physics_process(false)



func _process(delta):
	pass

func get_random_direction():
	if check_distance():
		owner.movement_direction = (owner.spawn_point - owner.global_position).normalized()
	else: 
		owner.movement_direction = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized()
		owner.movement_direction = Vector2(1,0)
		
	owner.jump()
	await get_tree().create_timer(3).timeout
	get_random_direction()


func check_distance():
	if owner.global_position.distance_to(owner.spawn_point) > owner.max_wander_distance:
		return true # too far
		
	
	
func enter():
	get_random_direction()
	set_physics_process(true)
	

func exit():
	set_physics_process(false)
