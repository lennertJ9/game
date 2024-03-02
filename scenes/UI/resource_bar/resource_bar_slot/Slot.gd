extends Control

signal ability_order_changed

@onready var ability_icon = $AbilityIcon
@onready var slot_texture = $SlotTexture

@onready var cooldown_timer = $CooldownTimer
@onready var update_timer = $UpdateTimer

@export var resource : Resource
var copy_resource : Resource


func _ready():
	update()
	
		


func update():
	if resource:
		ability_icon.texture_under = resource.icon
		ability_icon.texture_progress = resource.icon
		
		cooldown_timer.wait_time = resource.cooldown
		ability_icon.max_value = resource.cooldown
	else:
		ability_icon.texture_under = null
		ability_icon.texture_progress = null
		
	ability_order_changed.emit()

# UI updaten, progress van een ability cooldown
func start_cooldown():
	cooldown_timer.start()
	update_timer.start()


func _on_update_timer_timeout():
	ability_icon.value = cooldown_timer.time_left
	if ability_icon.value < 0:
		update_timer.stop()


func _get_drag_data(at_position):
	if resource:
		copy_resource = resource
		resource = null
		update()
		
		var preview = Control.new()
		preview.scale = Vector2(4,4)
		
		var preview_texture = TextureRect.new()
		preview_texture.texture = copy_resource.icon
		preview_texture.position = Vector2(-8,-8)
		preview.add_child(preview_texture)
		set_drag_preview(preview)
		return copy_resource


func _can_drop_data(at_position, data):
	return data is Ability


func _drop_data(at_position, data):
	resource = data
	update()
	start_cooldown()
	






#func _notification(notification_type):
	#match notification_type:
		#NOTIFICATION_DRAG_END:
			#print(is_drag_successful())





