extends Area2D

signal hit(area)




func _on_area_entered(area):
	hit.emit(area.damage)
	print(area.damage)



