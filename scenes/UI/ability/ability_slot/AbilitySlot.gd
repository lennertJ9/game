extends Control
class_name ability_slot


signal drag
signal drop

@export var current_ability: Ability
var input_key: String

@onready var progress_bar: Control = $ProgressBar




func _ready() -> void:
	if current_ability:
		progress_bar.texture_under = current_ability.icon
		progress_bar.texture_progress = current_ability.icon
	set_process(false)



func _process(delta: float) -> void:
	progress_bar.value = $CooldownTimer.time_left






func update_slot(ability: Ability) -> void:
	if ability:
		current_ability = ability
		progress_bar.texture_under = current_ability.icon
		progress_bar.texture_progress = current_ability.icon
	else:
		current_ability = null
		progress_bar.texture_under = null
		progress_bar.texture_progress = null



func _get_drag_data(at_position: Vector2) -> Variant:
	if current_ability:
		var data: Ability = current_ability
		drag.emit(data, get_index(),self)
		get_tree().get_first_node_in_group("UI").preview_manager.make_preview(data.icon)
		return data
	else:
		return null



func _can_drop_data(at_position: Vector2, data: Variant) -> bool :
	if data is Ability:
		return true
	else:
		return false



func _drop_data(at_position: Vector2, data: Variant) -> void:
	drop.emit(data, get_index(),self)



func start_cooldown(time: float) -> void:
	set_process(true)
	progress_bar.max_value = time 
	$CooldownTimer.wait_time = time 
	$CooldownTimer.start()



func _on_cooldown_timer_timeout() -> void:
	progress_bar.value = 0.0 # op 0.0 zetten want soms blijft er voor een of andere reden 0.2 over?
	set_process(false)



func _on_timer_timeout() -> void:
	if current_ability:
		drop.emit(current_ability, get_index())
