extends CanvasLayer

@onready var animation_player = $AnimationPlayer
@onready var color_rect = $ColorRect


const main = ("res://scenes/main/main.tscn")
const elder_wood = ("res://scenes/maps/elderwood/Elderwood.tscn")

func _ready():
	color_rect.hide()


func change_map(map_path):
	color_rect.show()
	animation_player.play("trans_in")
	await animation_player.animation_finished
	
	get_tree().change_scene_to_file(map_path)
	
	animation_player.play("trans_out")
	await animation_player.animation_finished
	color_rect.hide()
	
