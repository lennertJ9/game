extends CharacterBody2D
class_name Player

# tip voor later, signal manager (autoload mss )onderaan de tree die signalen verbind tussen nodes


@export var stats : Stats
@export var player_inventory : Inventory

# -------------- ANIMATIONS ---------------------------------
@onready var animation_player = $"ANIMATIONS/AnimationPlayer"
@onready var attack_animations = $"ANIMATIONS/AttackAnimations"


# -------------- VISUALS -----------------
@onready var visuals = $Visuals
@onready var run_dust = $Visuals/RunDust
@onready var hand_left = $Visuals/HandLeft
@onready var weapon = $Visuals/Weapon


# -------------- COMPONENTS --------------------
@export var hurt_box_component: Node2D
@export var health_component: Node
@export var status_component: Node


# ------------- MANAGERS -------------------------
@onready var ability_manager = $MANAGERS/AbilityManager


# walking system
var movement_direction: Vector2
var speed_status_modifier: float = 1.0
var target = Vector2.ZERO
var boolie = true


func _ready():
	update_player_stats()
	connect_signals()
	


<<<<<<< Updated upstream
func _process(delta):
	var direction_to_mouse = (get_global_mouse_position() - global_position).normalized()
	var target_position = global_position + Vector2(0,-4) + direction_to_mouse * 7
	


func _physics_process(_delta):
	velocity = movement_direction * stats.movement_speed * speed_status_modifier
	
	if position.distance_to(target) > 1:
		move_and_slide()
	else:
		animation_player.play("IDLE")
	


func _input(event):
	if event.is_action_pressed("right_click"):
		mouse_click_animation()
		target = get_global_mouse_position()
		movement_direction = position.direction_to(target)
		if !speed_status_modifier == 0:
			animation_player.play("RUN") 
=======
func _physics_process(_delta: float) -> void:
	get_input()
	move_and_slide()


func get_input():
	
	var input_direction: Vector2 = Input.get_vector("left","right","up","down")
	if input_direction.length() > 0:
		movement_direction = input_direction
	
	if input_direction.x != 0:
		animation_player.play("RUN_SIDE")
	elif input_direction.y > 0:
			animation_player.play("RUN_DOWN")
	elif input_direction.y < 0:
		animation_player.play("RUN_UP")
>>>>>>> Stashed changes
		
	else:
		if movement_direction.x != 0:
			animation_player.play("IDLE_SIDE")
		elif movement_direction.y > 0:
			animation_player.play("IDLE_DOWN")
		elif movement_direction.y < 0:
			animation_player.play("IDLE_UP")
	
	
	if input_direction.x > 0:
		visuals.scale.x = 1
	elif input_direction.x < 0:
		visuals.scale.x = -1
		
	velocity = input_direction * stats.movement_speed



func update_player_stats():
	pass



func hit_flash():
	var shader = $Visuals/Leg.material as ShaderMaterial
	shader.set_shader_parameter("amount", .8)
	shader.set_shader_parameter("active", true)
	await get_tree().create_timer(0.125).timeout
	shader.set_shader_parameter("active", false)



func hide_weapon():
	attack_animations.play('HIDE_WEAPON')
	

func play_animation():
	if boolie:
		attack_animations.play("ATTACK_DOWN")
		boolie = false
		
	else:
		attack_animations.play("ATTACK_DOWN_2")
		boolie = true



func mouse_click_animation():
	var animation = preload("res://scenes/animations/mouse_click/MouseClick.tscn").instantiate()
	var world = get_tree().get_first_node_in_group("world")
	animation.global_position = get_global_mouse_position() + Vector2(0,0)
	get_parent().add_child(animation)
<<<<<<< Updated upstream



func connect_signals():
	var UI = get_tree().get_first_node_in_group("UI")
	
	for slot in UI.ability_bar.slots:
		
		slot.drop.connect(ability_manager.set_ability)
	#ability_manager.ability_use.connect(UI.ability_bar.start_cooldown)







=======
>>>>>>> Stashed changes
