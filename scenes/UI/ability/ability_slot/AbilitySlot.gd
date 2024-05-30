extends Control
class_name ability_slot


signal drag
signal drop

@export var current_ability: Ability
@export var input_key: String

@onready var progress_bar = $ProgressBar




func _ready():
	if current_ability:
		
		
		progress_bar.texture_under = current_ability.icon
		progress_bar.texture_progress = current_ability.icon
	set_process(false)



func _process(delta):
	progress_bar.value = $CooldownTimer.time_left
	
	

func _get_drag_data(at_position):
	if current_ability:
		drag.emit(current_ability, get_index())
		var data = current_ability
		update_slot(null)
		return data





func update_slot(ability: Ability):
	if ability:
		current_ability = ability
		progress_bar.texture_under = current_ability.icon
		progress_bar.texture_progress = current_ability.icon
	else:
		current_ability = null
		progress_bar.texture_under = null
		progress_bar.texture_progress = null



func _can_drop_data(at_position, data):
	if data is Ability:
		return true



func _drop_data(at_position, data):
	update_slot(data)
	drop.emit(data, get_index())
	start_cooldown(current_ability.cooldown)



func start_cooldown(time: float):
	set_process(true)
	print("start ui cooldown")
	progress_bar.max_value = time 
	$CooldownTimer.wait_time = time 
	$CooldownTimer.start()



func _on_cooldown_timer_timeout():
	progress_bar.value = 0.0 # op 0.0 zetten want soms blijft er voor een of andere reden 0.2 over?
	set_process(false)







func _on_timer_timeout():
	if current_ability:
		drop.emit(current_ability, get_index())
