extends Node2D


func stun(time):
	owner.speed_status_modifier = 0.0
	await get_tree().create_timer(time).timeout
	owner.speed_status_modifier = 1.0
