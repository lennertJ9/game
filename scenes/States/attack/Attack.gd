extends state


signal attack_finished


func initialize():
	owner.animation_player.play("attack")


func finalize():
	pass


func _physics_process(delta):
	owner.velocity = Vector2.ZERO
