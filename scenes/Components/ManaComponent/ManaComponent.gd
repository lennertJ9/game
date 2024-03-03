extends Node2D

signal mana_changed


var stats : statistic

@onready var regenerate_timer = $RegenerateTimer


func _ready():
	stats = owner.stats


func check_mana(mana_amount):
	print("mana_amount: ", mana_amount)
	
	if mana_amount <= stats.current_mana:
		stats.current_mana -= mana_amount
		mana_changed.emit()
		return true
	else:
		return false


func _on_regenerate_timer_timeout():
	stats.current_mana += stats.mana_regeneration