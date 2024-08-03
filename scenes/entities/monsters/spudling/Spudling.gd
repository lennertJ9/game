extends CharacterBody2D


@export var stats: Stats
@export var animation_player: AnimationPlayer

@onready var sprite = $Sprite
@onready var nav_agent = $NavigationAgent2D
@onready var state_manager = $StateManager

@onready var wander = $StateManager/Wander
@onready var flee = $StateManager/Flee

@onready var raycast = $RayCast2D

var danger_area_pos: Vector2


func _ready():
	flee.flee_timer.connect(state_manager.change_state.bind(wander))
	


func check_sprite_direction(direction: Vector2):
	if direction.x < 0:
		$Sprite.scale.x = -1
	else:
		$Sprite.scale.x = 1



func _on_danger_area_area_entered(area):
	animation_player.play("scared")
	flee.danger = area
	state_manager.change_state(flee)



#func _input(event):
	#nav_agent.target_position = get_global_mouse_position()
	#if event.is_action_pressed("left_click"):
		#if nav_agent.is_target_reachable():
			#print("reachable")
		#else:
			#print("not reachable")
	
