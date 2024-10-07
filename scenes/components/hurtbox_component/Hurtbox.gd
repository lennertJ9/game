extends Area2D

signal hit(area) # emit wanneer geraakt door HitBox
signal status(area) # emit wanneer de HitBox een status effect veroorzaakt


var colliding_hitboxes: Dictionary


func _on_area_entered(area: HitBox):
	print("area entered: ", area)
	if area.collision_dot:
		hit.emit(area.damage)
		colliding_hitboxes[area] = create_timer(area)
	
	else:
		hit.emit(area.damage)



func create_timer(area: HitBox): # maakt timer, 
	var timer = Timer.new()
	timer.wait_time = area.dot_interval
	
	timer.timeout.connect(apply_collision_dot.bind(area.damage))
	add_child(timer)
	timer.start()
	return timer




func apply_collision_dot(damage):
	hit.emit(damage)




func _on_area_exited(area):
	print("area exited: ", area)
	var timer = colliding_hitboxes.get(area)
	remove_child(timer)
	timer.queue_free()
	
	colliding_hitboxes.erase(area)
	
<<<<<<< Updated upstream:scenes/components/hurtbox_component/Hurtbox.gd


func _input(event):
	if event.is_action_pressed("slot_1"):
		print(colliding_hitboxes)
=======
>>>>>>> Stashed changes:scenes/components/hurtbox_component/HurtboxComponent.gd
