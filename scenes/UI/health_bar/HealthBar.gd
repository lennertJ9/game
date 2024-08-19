extends TextureProgressBar


@onready var flash_bar = $FlashBar
@onready var animation_player = $AnimationPlayer




func _ready():
	if get_tree().get_first_node_in_group("player"):
		var player = get_tree().get_first_node_in_group("player")
		var player_stats: Stats = player.stats
		player.health_component.health_changed.connect(change_health)
		
		value = player_stats.current_health
		max_value = player_stats.max_health
		
		flash_bar.value = player_stats.current_health
		flash_bar.max_value = player_stats.max_health
		


func change_health(amount: int):
	if amount > value:
		heal_animation()
		value = amount
		flash_bar.value = amount
	else:
		value = amount
		animation_player.play("hit")
		$HitFlashTimer.start()


func damage_animation():
	var tween = create_tween()
	tween.tween_property(flash_bar, "value" ,value ,0.25)
	
	


func heal_animation():
	animation_player.play("heal")




func _on_timer_timeout():
	damage_animation()
