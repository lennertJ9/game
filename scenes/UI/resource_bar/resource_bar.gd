extends Control


@onready var slots = $Slots

@onready var health_bar: TextureProgressBar = $Health
@onready var mana_bar: TextureProgressBar = $Mana

@onready var health_label: Label = $HealthLabel
@onready var mana_label: Label = $ManaLabel



func update_health(health: int):
	health_bar.value = health


func update_mana(mana: int):
	mana_bar.value = mana


func _on_life_mouse_entered():
	health_label.visible = true


func _on_life_mouse_exited():
	health_label.visible = false



func _on_energy_mouse_entered():
	mana_label.visible = true


func _on_energy_mouse_exited():
	mana_label.visible = false

