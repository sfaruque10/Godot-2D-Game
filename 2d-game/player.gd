extends CharacterBody2D

@export var speed = 500
@export var dash_speed = 1200
@export var gravity = 30
@export var jump_force = 1000
@export var dash_jump = 1000

var jumps = 0
var dashes = 0
var is_dashing = false
var dash_direction = 0
var external_force: Vector2 = Vector2.ZERO
var friction = 100
var current_friction = 10000
var normal_deceleration = 1000.0
var slippery_deceleration = 100.0
var current_deceleration = normal_deceleration

func _ready() -> void:
	$AnimatedSprite2D.play("default") # sprite animation

func _physics_process(delta: float) -> void:
	if is_dashing:
		# use dash speed and change animation
		var target_speed = dash_speed * dash_direction * Global.gravity_direction
		velocity.x = move_toward(velocity.x, target_speed, current_friction * delta)
		
		$AnimatedSprite2D.play("dash")
		$Jump.stop()
		$Dash.play()
		velocity += external_force # add any force from environment
		velocity.y = 0
	else:
		if (!is_on_floor() and Global.gravity_direction == 1) or (!is_on_ceiling() and Global.gravity_direction == -1): # make player fall to ground
			# make player float down or up depending on gravity
			velocity.y += gravity * Global.gravity_direction
			if abs(velocity.y) > 1000:
				velocity.y = 1000 * Global.gravity_direction
			if velocity.y * Global.gravity_direction < 0:
				$AnimatedSprite2D.play("jump")  # animation for jump
			if velocity.y * Global.gravity_direction > 0:
				$AnimatedSprite2D.play("fall")  # animation for fall
		else:
			jumps = 0 # reset number of jumps
			dashes = 0 # reset number of dashes
		
		if Input.is_action_just_pressed("jump") and jumps < Global.max_jumps:
			velocity.y = -jump_force * Global.gravity_direction
			jumps += 1 # increment number of jumps
			$Jump.play()
			
		var direction = Input.get_axis("ui_left", "ui_right")
		
		# change sprite direction if moving left or right
		if direction == -1:
			$AnimatedSprite2D.flip_h = true 
		elif direction == 1:
			$AnimatedSprite2D.flip_h = false
		
		if direction:
			# move towards max speed
			var target_speed = speed * direction * Global.gravity_direction
			# move_toward for smooth acceleration
			velocity.x = move_toward(velocity.x, target_speed, current_friction * delta)
			$AnimatedSprite2D.play("movement")
			if speed == 2000 and not $Slip.playing: # slip sound
				$Slip.play()
		else:
			if is_on_floor() or is_on_ceiling():
				$AnimatedSprite2D.play("default")
			if current_deceleration == slippery_deceleration:
			# current_deceleration_rate to slow down gradually while on ice
				velocity.x = move_toward(velocity.x, 0, current_deceleration * delta)
			else:
				velocity.x = 0
		
		# force from wind
		velocity += external_force
		
		# press space while holding arrow key
		if Input.is_action_just_pressed("dash") and Global.has_dash == true and dashes < Global.max_dashes: # dash
			var dir = Input.get_axis("ui_left", "ui_right")
			if dir != 0: # if not standing in place
				dash_direction = dir
				is_dashing = true
				$Timer.start()
				dashes += 1
	
	move_and_slide()
	external_force = Vector2.ZERO
	
func _on_timer_timeout() -> void:
	is_dashing = false
	
func wind_push(force_amount: float):
	external_force.x = force_amount

func set_slippery_mode(is_slippery: bool):
	if is_slippery:
		speed = 2000
		dash_speed = 1500
		$AnimatedSprite2D.play("dash") # dash animation when slipping
		current_deceleration = slippery_deceleration
	else:
		speed = 500
		dash_speed = 1200
		$AnimatedSprite2D.play("default") # default animation
		current_deceleration = normal_deceleration

func rotate_player():
	if Global.gravity_direction == -1: # used to flip player 180
		var tween = create_tween()
		tween.tween_property($AnimatedSprite2D, "rotation_degrees", 180, 1.0)
	if Global.gravity_direction == 1:
		var tween = create_tween() # flip player back to normal
		tween.tween_property($AnimatedSprite2D, "rotation_degrees", 0, 1.0)
