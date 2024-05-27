extends Node


var knockback_source: Vector2
var knockback_strength: float

func _ready():
	set_physics_process(false)
	

func stun(time):
	owner.speed_status_modifier = 0.0
	await get_tree().create_timer(time).timeout
	owner.speed_status_modifier = 1.0


func knockback(source: Vector2, strength):
	knockback_source = source.normalized()
	knockback_strength = strength
	
	$Timer.start()
	owner.set_physics_process(false)
	set_physics_process(true)
	owner.animation_player.play("STUN")


func _physics_process(delta):
	owner.velocity = knockback_source * knockback_strength
	knockback_strength *= 0.9
	owner.move_and_slide()


func _on_timer_timeout():
	owner.movement_direction = Vector2.ZERO
	owner.set_physics_process(true)
	set_physics_process(false)
