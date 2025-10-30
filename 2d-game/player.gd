extends CharacterBody2D

@export var speed = 500
@export var dash_speed = 1200
@export var gravity = 30
@export var jump_force = 1000
@export var dash_jump = 1000

var jumps = 0
var dashes = 0
var max_dashes = 1
var max_jumps = 1
var is_dashing = false
var dash_direction = 0
#var gravity_direction = 1 # normal gravity or flipped gravity

func _physics_process(_delta: float) -> void:
	if is_dashing:
		velocity.x = dash_speed * dash_direction * Global.gravity_direction
		velocity.y = 0
	else:
		if (!is_on_floor() and Global.gravity_direction == 1) or (!is_on_ceiling() and Global.gravity_direction == -1): # make player fall to ground
			velocity.y += gravity * Global.gravity_direction
			if abs(velocity.y) > 1000:
				velocity.y = 1000 * Global.gravity_direction
		else:
			jumps = 0 # reset number of jumps
			dashes = 0 # reset number of dashes
		
		if Input.is_action_just_pressed("jump") and jumps < max_jumps:
			velocity.y = -jump_force * Global.gravity_direction
			jumps += 1 # increment number of jumps
			
		var direction = Input.get_axis("ui_left", "ui_right")
		velocity.x = speed * direction * Global.gravity_direction
		
		# press shift while holding arrow key
		if Input.is_action_just_pressed("dash") and Global.has_dash == true and dashes < max_dashes: # dash
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
	
func _on_timer_timeout() -> void:
	is_dashing = false


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
