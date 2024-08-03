extends state


func _physics_process(delta):
	owner.move_and_slide()



func initialize():
	await get_tree().physics_frame
	get_random_direction()
	$Timer.start()



func finalize():
	$Timer.stop()



func idle():
	owner.velocity = Vector2.ZERO
	owner.animation_player.play("idle")



func get_random_direction():
	var random_direction = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized() 
	owner.velocity = random_direction * owner.stats.movement_speed
	owner.animation_player.play("running")
	owner.check_sprite_direction(random_direction)



func _on_timer_timeout():
	idle()
	await get_tree().create_timer(randf_range(2,5)).timeout
	get_random_direction()
	
	if is_active:
		$Timer.wait_time = randf_range(1,3)
		$Timer.start()

