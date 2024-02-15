extends Node2D


@export var max_health: int
var current_health: int

func _ready():
	current_health = max_health
	
func _input(event):
	if event.is_action_pressed("debug"):
		
			
			var hurtboxscene = get_node("../visuals/HurtBox")
			if hurtboxscene != null:
				get_node("../visuals/HurtBox").hit.connect(_on_hurt_box_hit)
			#print("connect")
			#hurtboxscene.hit.connect(_on_hurt_box_hit)

func _on_hit():
	print("ouch")

func _on_hurt_box_hit():
	current_health -= 1
	print("health now", current_health)
	if current_health <= 0:
		await get_tree().create_timer(0.1).timeout
		owner.queue_free()
