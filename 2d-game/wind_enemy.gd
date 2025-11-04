extends CharacterBody2D

@export var push_force: float = 100.0 
@export var wind_direction: int = 1 
var player = null

func _on_body_entered(body):
	# check if the entered body is the player 
	if body.name == "Player":
		player = body

func _on_body_exited(body):
	if body == player:
		player = null

func _physics_process(_delta):
	if player:
		#var direction_x = sign(player.global_position.x - global_position.x)
		# apply the horizontal force
		var direction_x = sign(player.global_position.x - global_position.x)
		player.wind_push(direction_x * push_force)


func _on_kill_zone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		die()

func die():
	queue_free()
