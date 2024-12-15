extends Node2D

@onready var dead_label = $DeadLabel
@onready var timer = $Timer

func die():
	# If we're already dead, return
	if !$Timer.is_stopped():
		return
	var flappy = get_tree().get_first_node_in_group("player_group") as Node2D
	dead_label.visible = true
	dead_label.global_position = flappy.global_position
	timer.start()
	Engine.time_scale = 0.5

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
