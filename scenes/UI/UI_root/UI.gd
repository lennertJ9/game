extends CanvasLayer


@export var player_stats : Resource

@onready var ability_slots = $ResourceBar/AbilitySlots
@onready var life = $ResourceBar/Life
@onready var energy = $ResourceBar/Energy


func _ready():
	update_health(player_stats.health)
	update_properties()
	print(ability_slots.get_children())


func update_health(health):
	life.value = health
	


func update_properties():
	life.max_value = player_stats.health


func start_slot_cooldown(index):
	ability_slots.get_child(index).start_cooldown()




