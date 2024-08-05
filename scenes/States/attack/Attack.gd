extends state


signal attack_finished


func initialize():
	owner.animation_player.play("attack")
	owner.sword_hit_box.movement_direction = owner.velocity.normalized()


func finalize():
	pass


func _physics_process(delta):
	owner.velocity = Vector2.ZERO
