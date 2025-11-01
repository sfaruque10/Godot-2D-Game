extends CharacterBody2D


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("set_slippery_mode"):
		body.set_slippery_mode(true)


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("set_slippery_mode"):
		body.set_slippery_mode(false)
