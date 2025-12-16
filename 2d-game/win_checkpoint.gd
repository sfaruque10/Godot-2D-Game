extends Area2D

func _on_body_entered(_body: Node2D) -> void:
	if Global.won == false:
		Global.won = true
		# game comletion audio queue
		$WinSound.play()
		# display label indicating the player won
		var tween: Tween = create_tween()
		tween.tween_property($WinLabel, "modulate", Color.WHITE, 1)
		await get_tree().create_timer(5.0).timeout
		var tween1: Tween = create_tween()
		tween1.tween_property($WinLabel, "modulate:a", 0.0, 1)
		tween1.finished.connect(func(): $WinLabel.visible = false)
		
