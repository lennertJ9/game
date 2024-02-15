extends Area2D

signal hit

func _ready():
	var health_component = get_node("../HealthComponent")

	print(health_component)
	

func _on_area_entered(area):
	area.remove_bullet()
	print("emit")
	hit.emit()



