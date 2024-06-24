extends Camera2D

var default_zoom: Vector2 = Vector2(4,4)



func _process(delta):
	global_position = get_tree().get_first_node_in_group("player").position



func focus(pos,x_zoom,y_zoom):
	set_process(false)
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(self,"zoom",Vector2(x_zoom,y_zoom),0.60,).set_ease(Tween.EASE_IN)
	tween.parallel().tween_property(self,"position",pos,0.40).set_ease(Tween.EASE_IN)
	


func end_focus():
	set_process(true)
	zoom = default_zoom

	
