extends state

signal attack_finished

var attack_ready: bool = true


func initialize():
	owner.animation_player.play("idle")
	$AttackSpeedTimer.wait_time = 1 / owner.stats.attack_speed
	basic_attack()


func finalize():
	pass


func _physics_process(delta):
	owner.velocity = Vector2.ZERO
	owner.move_and_slide()



func basic_attack():
	if attack_ready:
		var anim: AnimationPlayer = owner.animation_player
		anim.stop()
		
		owner.sword_animation.play("attack")
		owner.sword_hit_box.knockback_direction = owner.velocity.normalized()
		attack_ready = false
		$AttackSpeedTimer.start()
		await owner.sword_animation.animation_finished
		owner.animation_player.play("idle")


func _on_attack_speed_timer_timeout():
	attack_ready = true
	if is_active:
		basic_attack()
	
