extends CanvasLayer

@onready var animation_player = $AnimationPlayer
@onready var color_rect = $ColorRect


const main = preload("res://scenes/main/main.tscn")
const elder_wood = preload("res://scenes/maps/elderwood/Elderwood.tscn")

func _ready():
	color_rect.hide()


func change_map(map_path,x,y):
	
	color_rect.show()
	animation_player.play("trans_in")
	await animation_player.animation_finished
	
	var map = map_path.instantiate()
	get_tree().get_root().get_child(3).free() # mss queue free idk
	get_tree().get_root().add_child(map)
	map.get_node("Player").global_position = Vector2(x,y)
	animation_player.play("trans_out")
	
	await animation_player.animation_finished
	color_rect.hide()
	
