extends CharacterBody2D

@export var push_force: float = 600.0
@export var wind_direction: int = 1
var player = null

func _on_body_entered(body):
	# check if body entered is player
	if body.name == "Player":
		player = body

func _on_body_exited(body):
	if body == player:
		player = null

func _physics_process(delta):
	if player:
		#var direction_x = sign(player.global_position.x - global_position.x)
		# apply force of wind to player
		var direction_x = sign(player.global_position.x - global_position.x)
		player.wind_push(direction_x * push_force)
