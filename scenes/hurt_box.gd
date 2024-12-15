class_name HurtBox
extends Area2D



func _on_area_entered(killzone: Killzone) -> void:
	if killzone == null:
		return
	owner.die()
	 
	var death_manager = get_node("/root/game/DeathManager")
	death_manager.die()
