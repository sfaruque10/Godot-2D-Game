extends Area2D





func _on_body_entered(_body: Node2D) -> void:	
	if Global.has_dash == false:
		Global.has_dash = true
		var tween = create_tween()
		tween.tween_property($DashLabel, "modulate", Color.WHITE, 1)
		await get_tree().create_timer(5.0).timeout
		var tween1 = create_tween()
		tween1.tween_property($DashLabel, "modulate:a", 0.0, 1)
		tween1.finished.connect(func(): $DashLabel.visible = false)
	#Global.change_text("You now have the ability to dash")
	pass # Replace with function body.
