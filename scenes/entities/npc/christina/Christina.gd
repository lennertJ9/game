extends CharacterBody2D


@onready var random_timer = $RandomTimer
@onready var animation_player = $AnimationPlayer
@onready var animation_player_2 = $AnimationPlayer2



func _on_timer_timeout():
	random_timer.wait_time = randf_range(3,10)
	print(random_timer.wait_time)
	animation_player_2.play("EYE_BLINK")
