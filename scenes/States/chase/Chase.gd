extends state


var target: CharacterBody2D
var agent: NavigationAgent2D
var desired_velocity

func initialize():
	owner.animation_player.play("running")
	agent = owner.nav_agent
	$Timer.start()


func finalize():
	pass



func _physics_process(delta):
	if owner.global_position.distance_to(target.global_position) < 20:
		owner.velocity = Vector2.ZERO
		owner.animation_player.play("idle")
	else:
		if owner.animation_player.current_animation != "running":
			owner.animation_player.play("running")
		calculate_direction()
	print(owner.velocity)
	owner.move_and_slide()




func calculate_direction():
		var next_path_position = agent.get_next_path_position()
		
		if agent.avoidance_enabled:
			owner.velocity = owner.global_position.direction_to(next_path_position) * owner.stats.movement_speed
			
		else:
			owner.velocity = owner.global_position.direction_to(next_path_position) * owner.stats.movement_speed


func _on_timer_timeout():
	if target:
		agent.target_position = target.global_position
		var dir = owner.global_position.direction_to(agent.target_position)
		owner.check_sprite_direction(dir)
