extends Sprite2D



func _ready() -> void:
	$AnimationPlayer.play("mouse_click")




func _on_animation_player_animation_finished(anim_name:String) -> void:
	queue_free()
