extends Area2D

signal hit(area)

func _ready():
	pass
	

func _on_area_entered(area):
	
	
	hit.emit(area)



