extends Node




func _ready():
	set_physics_process(false)



func get_random_direction():
	if check_distance():
		owner.movement_direction = (owner.spawn_point - owner.global_position).normalized()
	else: 
		owner.movement_direction = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized()


func check_distance():
	if owner.global_position.distance_to(owner.spawn_point) > owner.max_wander_distance:
		return true # too far
		
	
	
func enter():
	set_physics_process(true)
	get_random_direction()
	$Timer.start()
	owner.specific_wander_logic()

func exit():
	set_physics_process(false)
	$Timer.stop()


func _on_timer_timeout():
	$Timer.wait_time = randf_range(1,4)
	get_random_direction()
	owner.specific_wander_logic()
	
