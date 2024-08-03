extends Node2D

signal health_changed


var stats : Stats

#var max_health: int
#var current_health: int

func _ready():
	stats = owner.stats
	
	
	
func damage(amount):
	stats.current_health -= amount
	
	
	if stats.current_health <= 0:
		await get_tree().create_timer(0.1).timeout
		owner.queue_free()
	
	health_changed.emit()


func _on_regenerate_timer_timeout():
	if stats.current_health < stats.max_health:
		stats.current_health += stats.health_regeneration
	
	
	
