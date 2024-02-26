extends Node

@onready var animation_player_2 = $"../../AnimationPlayer2"
@onready var bolt_manager = $"../../BoltManager"

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)
	attack()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func attack():
	animation_player_2.play("attack")
	wait()

func wait():
	await get_tree().create_timer(2).timeout
	attack()

func enter():
	attack()

func shoot():
	bolt_manager.shoot(Vector2(-1,0), owner.position)
