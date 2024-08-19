extends Node
class_name HealthComponent

signal health_changed

var stats: Stats


func _ready():
	stats = owner.stats
	owner.hurt_box_component.hit.connect(damage)



func damage(amount):
	owner.hit_flash()
	stats.current_health -= amount
	if stats.current_health < 0:
		stats.current_health = 0

	
	health_changed.emit(stats.current_health)
