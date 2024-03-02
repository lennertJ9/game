extends Control

var index : int

@onready var ability_icon = $AbilityIcon
@onready var slot_texture = $SlotTexture

@onready var cooldown_timer = $CooldownTimer
@onready var update_timer = $UpdateTimer

@export var resource : Resource
var copy_resource : Resource


func _ready():
	update()
	if resource:
		cooldown_timer.wait_time = resource.cooldown
	print(owner.owner)



func update():
	if resource:
		ability_icon.texture_under = resource.icon
	else:
		ability_icon.texture_under = null


# UI updaten, progress van een ability cooldown
func update_progress():
	ability_icon.texture_progress = cooldown_timer.time_left


func _get_drag_data(at_position):
	if resource:
		copy_resource = resource
		resource = null
		update()
		
		var preview = Control.new()
		preview.scale = Vector2(3,3)
		
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
	ability_icon.texture_under = data.icon
	
	owner.owner.projectile_manager.update_slots()


#func _notification(notification_type):
	#match notification_type:
		#NOTIFICATION_DRAG_END:
			#print(is_drag_successful())


func _on_update_timer_timeout():
	update_progress()


