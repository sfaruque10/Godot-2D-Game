extends CharacterBody2D


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("set_slippery_mode"):
		# make player slip on ice
		body.set_slippery_mode(true)


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("set_slippery_mode"):
		# make player have normal speed
		body.set_slippery_mode(false)


func _on_kill_zone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		# destroy enemy
		die()

func die():
	queue_free()
