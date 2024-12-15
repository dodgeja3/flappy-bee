extends Node2D

var spawn_wall = preload("res://scenes/wall.tscn")

const X_FROM_FLAPPY = 181
const Y_MIN = 40

@onready var timer = $Timer


func _process(delta: float) -> void:
	var wall = spawn_wall.instantiate() as Node2D
	var flappy = get_tree().get_first_node_in_group("player_group") as Node2D
	
	# Get last wall if available, else first wall y pos is -100
	var y_pos = 100
	if get_tree().get_nodes_in_group("wall_group").size() > 0:
		var last_wall = get_tree().get_nodes_in_group("wall_group")[-1] as Node2D
		y_pos = last_wall.position.y
		
	# Spawn in front of flappy's pos.x, at a random pos.y 
	wall.global_position = Vector2(flappy.position.x + X_FROM_FLAPPY, min(Y_MIN, y_pos + randi_range(-30, 30)))
	
	if $Timer.is_stopped():
		add_child(wall)
		$Timer.start()
		print("Spawned Wall!")
		for existing_wall in get_tree().get_nodes_in_group("wall_group"):
			if existing_wall.shouldClear():
				print("Deleting wall")
				existing_wall.queue_free()
		
