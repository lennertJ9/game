extends CharacterBody2D
#class_name player


signal stats_updated


@export var stats : statistic

# -------------- ANIMATIONS ---------------------------------
@onready var animation_tree = $AnimationTree as AnimationTree
@onready var animation_player = $AnimationPlayer
@onready var attack_animations = $AttackAnimations


# -------------- VISUALS -----------------
@onready var visuals = $Visuals
@onready var run_dust = $Visuals/RunDust
@onready var hand_left = $Visuals/HandLeft
@onready var weapon = $Visuals/Weapon

# -------------- COMPONENTS --------------------
@onready var hurt_box = $HurtBoxComponent
@onready var health_component = $HealthComponent
@onready var mana_component = $ManaComponent

# -------------- ABILITIES -----------------------
@onready var projectile_manager = $ProjectileManager


# -------------- UI --------------------------------
@onready var resource_bar = $CanvasLayer/ResourceBar


# walking system
var movement_direction: Vector2
var current_direction: Vector2
var speed_status_modifier: float = 1.0
var target = Vector2.ZERO


var boolie = true


func _ready():
	hurt_box.hit.connect(on_player_hit)
	update_player_stats()
	

func _process(delta):
	var direction_to_mouse = (get_global_mouse_position() - global_position).normalized()
	var target_position = global_position + Vector2(0,-4) + direction_to_mouse * 7


func _physics_process(_delta):
	velocity = movement_direction * stats.movement_speed * speed_status_modifier
	
	if position.distance_to(target) > 1:
		
		move_and_slide()
	else:
		$AnimationPlayer.play("IDLE")
		
		
		
func _input(event):
	if event.is_action_pressed("right_click"):
		target = get_global_mouse_position()
		movement_direction = global_position.direction_to(target)
		if !speed_status_modifier == 0:
			$AnimationPlayer.play("RUN") 
		
			if movement_direction.x < 0:
				visuals.scale.x = -1
			else:
				visuals.scale.x = 1
		
	#if event.is_action_pressed("magic_bolt"):
		#$Abilities/BoltManager.shoot(global_position.direction_to(get_global_mouse_position()), position)
		#
	#if event.is_action_pressed("fireball"):
		#$Abilities/FireballManager.shoot(global_position.direction_to(get_global_mouse_position()), position)
	
	if event.is_action_pressed("slot_1"):
		slot_press(0)
	
	if event.is_action_pressed("slot_2"):
		slot_press(1)
	
	if event.is_action_pressed("slot_3"):
		slot_press(2)
	
	if event.is_action_pressed("slot_4"):
		slot_press(3)
	
	if event.is_action_pressed("slot_5"):
		slot_press(4)

	if event.is_action_pressed("debug"):
		print("debug")
		$StatusManager.stun(2)
		$AnimationPlayer.play("STUN")
		#var slots = get_tree().get_first_node_in_group("UI").ability_slots
		#print("slots --> ",slots)


func slot_press(index):
	$ProjectileManager.get_child(index).use_ability()


func update_player_stats():
	
	stats_updated.emit()
	

func on_player_hit(area):
	health_component.damage(area.damage)
	#resource_bar.update_health(health_component.current_health)
	
	
	var shader = $Visuals/Legs.material as ShaderMaterial
	shader.set_shader_parameter("amount", .8)
	shader.set_shader_parameter("active", true)
	await get_tree().create_timer(0.125).timeout
	shader.set_shader_parameter("active", false)
	
	$StatusManager.stun(2)

func hide_weapon():
	attack_animations.play('HIDE_WEAPON')
	

func play_animation():
	if boolie:
		attack_animations.play("ATTACK_DOWN")
		boolie = false
		
	else:
		attack_animations.play("ATTACK_DOWN_2")
		boolie = true

