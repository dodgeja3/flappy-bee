extends Area2D

@onready var animation_player = $AnimationPlayer
@onready var audio_player = $AudioStreamPlayer2D

func _on_body_entered(body: Node2D) -> void:
	print("You get a point!")
	audio_player.play()
