extends Control

@onready var icon_progress_bar = $TextureProgressBar
@onready var slot_texture = $SlotTexture

var cooldown: int

func set_icon(png):
	icon_progress_bar.texture_progress = png
	icon_progress_bar.texture_under = png


func _ready():
	timer(1)
	icon_progress_bar.step = 0.01
	icon_progress_bar.max_value = 1


func _process(delta):
	$TextureProgressBar.value = $Timer.time_left
	
	


func timer(cooldown):
	$Timer.wait_time = cooldown
	$Timer.start()
	
