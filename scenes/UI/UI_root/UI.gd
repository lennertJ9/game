extends CanvasLayer


@export var player_stats : statistic

@onready var ability_slots = $ResourceBar/AbilitySlots
@onready var life_bar = $ResourceBar/Life
@onready var mana_bar = $ResourceBar/Mana


func _ready():
	update_health()
	update_mana()
	update_properties()
	


func update_health():
	life_bar.value = player_stats.current_health

func update_mana():
	mana_bar.value = player_stats.current_mana


func update_properties():
	life_bar.max_value = player_stats.max_health
	mana_bar.max_value = player_stats.max_mana


func start_slot_cooldown(index):
	ability_slots.get_child(index).start_cooldown()


func _on_update_resources_timeout():
	update_mana()
	update_health()
	


func _on_mana_mouse_entered():
	print(player_stats.current_mana)
