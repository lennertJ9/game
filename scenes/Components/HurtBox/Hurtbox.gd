extends Area2D

signal hit(area)

func _ready():
	pass
	

func _on_area_entered(area):
	area.remove_bullet()
	print("emit")
	hit.emit(area)



