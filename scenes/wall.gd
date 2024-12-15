extends Node2D

@onready var clear_timer = $ClearTimer

func shouldClear():
	if clear_timer.is_stopped():
		return true
	else:
		return false
