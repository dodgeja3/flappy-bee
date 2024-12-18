extends CharacterBody2D

const SPEED = 50.0
const JUMP_VELOCITY = -125.0
const GRAVITY_SCALE = 0.30

@onready var jump_timer = $JumpTimer
@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D
@onready var animation_player = $AnimationPlayer
@onready var flap_audio = $AudioStreamPlayer2D
@onready var hurt_box = $HurtBox
@onready var is_dead = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * GRAVITY_SCALE * delta
		
	if is_dead:
		move_and_slide()
		return

	# Play flap animation
	if $JumpTimer.is_stopped():
		animated_sprite.play("default")
		
		
	# Only jump if allowed
	if Input.is_action_just_pressed("jump") and $JumpTimer.is_stopped():
		velocity.y = JUMP_VELOCITY
		$JumpTimer.start()
		flap_audio.play()
		animation_player.stop(true)
		animation_player.play("flap")

	# Go fast and RIIIIGHT
	velocity.x = 1 * SPEED

	move_and_slide()

func die():
	animation_player.play("die")
	# Disable collision shape to avoid hitting other things when dead
	collision_shape.set_deferred("disabled", true)
	is_dead = true
