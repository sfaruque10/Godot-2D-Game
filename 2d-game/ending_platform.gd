extends Area2D

var player = null

#func _on_body_entered(body: Node2D) -> void:
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


func _on_body_entered(body: Node2D) -> void:
	
	print(get_groups())
	print(body.name)

	if is_in_group("Negative_Gravity"):
		print("working")
	else:
		print("not")
	if Global.gravity_direction == 1 and body.name == "Player" and is_in_group("Negative_Gravity"):
		player = body
		Global.gravity_direction = -1 # change gravity
		player.rotate_player() # flip sprite
		print("gravity change")
	elif Global.gravity_direction == -1 and body.name == "Player" and not is_in_group("Negative_Gravity"):
		player = body
		Global.gravity_direction = 1 # gravity back to normal
		player.rotate_player() # rotate player back to normal
		print("gravity change")
