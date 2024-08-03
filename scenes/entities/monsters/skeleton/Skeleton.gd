extends CharacterBody2D


@export var stats: Stats

@onready var animation_player = $AnimationPlayer

func _ready():
	pass

func check_sprite_direction(direction: Vector2):
	if direction.x < 0:
		$Visuals.scale.x = -1
	else:
		$Visuals.scale.x = 1


func _input(event):
	if event.is_action_pressed("debug"):
		print("debug")
		var anim: Animation = animation_player.get_animation("running")
		var track = anim.find_track("Visuals/Sword:rotation",Animation.TYPE_VALUE)
		print(track)
		anim.track_set_enabled(track, false)




func _on_area_2d_mouse_entered():
	print("mouse entered")
	$SwordAnimation.play("engage")
	await $SwordAnimation.animation_finished
	var current_time = $AnimationPlayer.current_animation_position
	$SwordAnimation.play("enage_idle")
	$SwordAnimation.advance(current_time)
	
