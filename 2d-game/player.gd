extends CharacterBody2D

@export var speed = 500
@export var dash_speed = 1200
@export var gravity = 30
@export var jump_force = 1000

var jumps = 0
var max_jumps = 2
var is_dashing = false
var dash_direction = 0

func _physics_process(_delta: float) -> void:
	if is_dashing:
		velocity.x = dash_speed * dash_direction
	else:
		if !is_on_floor(): # make player fall to ground
			velocity.y += gravity
			if velocity.y > 1000:
				velocity.y = 1000
		else:
			jumps = 0 # reset number of jumps
		
		if Input.is_action_just_pressed("jump") and jumps < max_jumps:
			velocity.y = -jump_force
			jumps += 1 # increment number of jumps
			
		var direction = Input.get_axis("ui_left", "ui_right")
		velocity.x = speed * direction
		
		# press space while holding arrow key
		if Input.is_action_just_pressed("dash"): # dash
			var dir = Input.get_axis("ui_left", "ui_right")
			if dir != 0: # if not standing in place
				dash_direction = dir
				is_dashing = true
				$Timer.start()
	
	move_and_slide()

	
func _on_timer_timeout() -> void:
	is_dashing = false
