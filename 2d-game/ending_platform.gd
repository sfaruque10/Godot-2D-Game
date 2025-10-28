extends Area2D


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
	#print(Global.gravity_direction)
	if is_in_group("Negative_Gravity"):
		print("working")
	else:
		print("not")
	if body.name == "Player" and is_in_group("Negative_Gravity"):
	#if body.name == "Player":
		Global.gravity_direction = -1
		print("gravity change")
	elif body.name == "Player" and not is_in_group("Negative_Gravity"):
		Global.gravity_direction = 1
		print("gravity change")
