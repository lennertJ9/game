extends CharacterBody2D


@onready var random_timer = $RandomTimer
@onready var animation_player = $AnimationPlayer
@onready var animation_player_2 = $AnimationPlayer2

var player_in_area: bool = false
var in_dialog: bool = false


func _ready():
	Dialogic.signal_event.connect(end_dialogue)


func _process(delta):
	if player_in_area and not in_dialog:
		if Input.is_action_just_pressed("Interact"):
			in_dialog = true
			run_dialogue("christina_giving")
	

func _on_timer_timeout():
	random_timer.wait_time = randf_range(3,10)
	print(random_timer.wait_time)
	animation_player_2.play("EYE_BLINK")


func _on_dialog_detection_body_entered(body):
	player_in_area = true


func _on_dialog_detection_body_exited(body):
	player_in_area = false


func run_dialogue(dialogue):
	get_tree().get_first_node_in_group("Camera").focus(position,4.5,4.5)
	get_tree().get_first_node_in_group("player").status_manager.pause()
	
	Dialogic.start(dialogue)



func end_dialogue(arg: String):
	print("end convo")
	in_dialog = false
	
	get_tree().get_first_node_in_group("Camera").end_focus()
	get_tree().get_first_node_in_group("player").status_manager.un_pause()
