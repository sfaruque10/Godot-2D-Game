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
#var gravity_direction = 1 # normal gravity or flipped gravity

func _ready() -> void:
	$AnimatedSprite2D.play("default")

func _physics_process(delta: float) -> void:
	if is_dashing:
		var target_speed = dash_speed * dash_direction * Global.gravity_direction
		velocity.x = move_toward(velocity.x, target_speed, current_friction * delta)
		#velocity.x = dash_speed * dash_direction * current_friction * delta * Global.gravity_direction
		$AnimatedSprite2D.play("dash")
		velocity += external_force
		velocity.y = 0
	else:
		if (!is_on_floor() and Global.gravity_direction == 1) or (!is_on_ceiling() and Global.gravity_direction == -1): # make player fall to ground
			velocity.y += gravity * Global.gravity_direction
			if abs(velocity.y) > 1000:
				velocity.y = 1000 * Global.gravity_direction
				#$AnimatedSprite2D.play("fall")
			if velocity.y * Global.gravity_direction < 0:
				$AnimatedSprite2D.play("jump") 
			if velocity.y * Global.gravity_direction > 0:
				$AnimatedSprite2D.play("fall") 
		else:
			jumps = 0 # reset number of jumps
			dashes = 0 # reset number of dashes
		
		if Input.is_action_just_pressed("jump") and jumps < Global.max_jumps:
			velocity.y = -jump_force * Global.gravity_direction
			#$AnimatedSprite2D.play("jump")
			jumps += 1 # increment number of jumps
			
		var direction = Input.get_axis("ui_left", "ui_right")
		
		if direction == -1:
			$AnimatedSprite2D.flip_h = true
		elif direction == 1:
			$AnimatedSprite2D.flip_h = false
		#velocity.x = speed * direction * current_friction * delta * Global.gravity_direction
		#velocity.lerp(Vector2.ZERO, current_deceleration)
		if direction:
			# move towards max speed
			var target_speed = speed * direction * Global.gravity_direction
			# move_toward for smooth acceleration
			velocity.x = move_toward(velocity.x, target_speed, current_friction * delta)
			$AnimatedSprite2D.play("movement")
			if speed == 2000 and not $Slip.playing:
				$Slip.play()
		else:
			if is_on_floor() or is_on_ceiling():
				$AnimatedSprite2D.play("default")
			if current_deceleration == slippery_deceleration:
			# current_deceleration_rate to slow down gradually while on ice
				velocity.x = move_toward(velocity.x, 0, current_deceleration * delta)
			else:
				velocity.x = 0
		velocity += external_force
		
		# press shift while holding arrow key
		if Input.is_action_just_pressed("dash") and Global.has_dash == true and dashes < Global.max_dashes: # dash
			var dir = Input.get_axis("ui_left", "ui_right")
			if dir != 0: # if not standing in place
				dash_direction = dir
				is_dashing = true
				$Timer.start()
				dashes += 1
			#elif dir == 0 and jumps < max_jumps: # dash jump
				#velocity.y = -dash_jump * Global.gravity_direction
				#jumps += 1
				#dashes += 1
	
	move_and_slide()
	external_force = Vector2.ZERO
	
func _on_timer_timeout() -> void:
	is_dashing = false
	
func wind_push(force_amount: float):
	external_force.x = force_amount

func set_slippery_mode(is_slippery: bool):
	if is_slippery:
		#current_friction = 200
		speed = 2000
		dash_speed = 1500
		$AnimatedSprite2D.play("dash")
		current_deceleration = slippery_deceleration
	else:
		#current_friction = friction
		speed = 500
		dash_speed = 1200
		$AnimatedSprite2D.play("default")
		current_deceleration = normal_deceleration

func rotate_player():
	if Global.gravity_direction == -1: # used to flip player 180
		var tween = create_tween()
		tween.tween_property($AnimatedSprite2D, "rotation_degrees", 180, 1.0)
	if Global.gravity_direction == 1:
		var tween = create_tween() # flip player back to normal
		tween.tween_property($AnimatedSprite2D, "rotation_degrees", 0, 1.0)

#func _on_ending_platform_body_entered(body: Node2D) -> void:
	#print(get_groups())
	#print(body.name)
	#if is_in_group("Negative_Gravity"):
		#print("working")
	#else:
		#print("not")
	#if body.name == "Player":
	##if body.name == "Player":
		#Global.gravity_direction *= -1
		#print("gravity change")
