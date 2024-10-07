extends Area2D

signal hit(area) # emit wanneer geraakt door HitBox
signal status(area) # emit wanneer de HitBox een status effect veroorzaakt

var damage_number = preload("res://scenes/autoloads/damage_numbers/damage_number.tscn")
var colliding_hitboxes: Dictionary


func _on_area_entered(area: HitBox):
	
	if area.collision_dot:
		hit.emit(area.damage)
		colliding_hitboxes[area] = create_timer(area)
	
	else:
		display_damage_number(area.damage)
		hit.emit(area.damage)
		



func create_timer(area: HitBox): # maakt timer, 
	var timer = Timer.new()
	timer.wait_time = area.dot_interval
	
	timer.timeout.connect(apply_collision_dot.bind(area.damage))
	add_child(timer)
	timer.start()
	return timer


func display_damage_number(damage_amount: int):
	var label = damage_number.instantiate()
	label.damage_number = damage_amount
	add_child(label)


func apply_collision_dot(damage):
	hit.emit(damage)




func _on_area_exited(area):
	if area.collision_dot:
		
		var timer = colliding_hitboxes.get(area)
		remove_child(timer)
		timer.queue_free()
		
		colliding_hitboxes.erase(area)
	

