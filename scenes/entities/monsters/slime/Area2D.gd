extends Area2D

var damage:int = 10
var movement_direction = Vector2.ZERO
var knockback = true
var knockback_strength = 225

func remove_bullet():
	owner.state_manager.disable_current_process()
	owner.status_manager.knockback(-movement_direction, 50)
	owner.current_direction = Vector2.ZERO
	
	
	owner.visuals.offset.y = 0
	
