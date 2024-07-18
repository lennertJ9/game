extends state

signal flee_timer

var agent: NavigationAgent2D
var danger: Node
var run_distance = 300
var recalculate_amounts: int = 0
var current_flee_direcion: Vector2


func _physics_process(delta):
	if agent.is_navigation_finished():
		owner.animation_player.play("idle")
		
	else:
		var next_path_position = agent.get_next_path_position()
		owner.velocity = owner.get_global_position().direction_to(next_path_position) * owner.stats.movement_speed * 1.8
		owner.move_and_slide()



func initialize():
	print("enter flee")
	await get_tree().physics_frame
	owner.animation_player.speed_scale = 2

	agent = owner.nav_agent
	calculate_velocity()
	owner.animation_player.play("scared")
	await owner.animation_player.animation_finished
	owner.animation_player.play("running")
	$Timer.start()



func finalize():
	print("end state flee")
	$Timer.stop()
	owner.animation_player.speed_scale = 1.25
	
	

func calculate_velocity():
	var rotation_degrees = recalculate_amounts * 30
	current_flee_direcion = current_flee_direcion.rotated(deg_to_rad(rotation_degrees))
	current_flee_direcion = -(owner.global_position.direction_to(danger.global_position))
	agent.target_position = owner.global_position + run_distance * current_flee_direcion
	owner.check_sprite_direction(current_flee_direcion)
	owner.animation_player.play("running")
	check_path()



func check_path():
	await get_tree().physics_frame   # denk omdat navigation pas waardes zet na de physics frame, anders staan er geen path waardes in de array
	
	var path :PackedVector2Array = agent.get_current_navigation_path()
	var distance = path[0].distance_to(path[-1])
	
	if distance < 150:
		if recalculate_amounts < 100:
			recalculate_amounts += 1
			calculate_velocity()
	else:
		recalculate_amounts = 0
		




func _on_timer_timeout():
	flee_timer.emit()
