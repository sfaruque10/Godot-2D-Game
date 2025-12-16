extends Area2D

#
#func _ready():
	#$DoubleJumpLabel.modulate = Color.TRANSPARENT

func _on_body_entered(_body: Node2D) -> void:
	if Global.max_jumps == 1:
		Global.max_jumps = 2
		# Notification of ability to double jump
		var tween: Tween = create_tween()
		var tween2: Tween = create_tween()
		tween.tween_property($DoubleJumpLabel, "modulate", Color.WHITE, 1)
		tween2.tween_property($Sprite2D, "modulate", Color.WHITE, 1)
		await get_tree().create_timer(5.0).timeout
		var tween1: Tween = create_tween()
		var tween3: Tween = create_tween()
		tween1.tween_property($DoubleJumpLabel, "modulate:a", 0.0, 1)
		tween3.tween_property($Sprite2D, "modulate:a", 0.0, 1)
		tween1.finished.connect(func(): $DoubleJumpLabel.visible = false)
		tween3.finished.connect(func(): $Sprite2D.visible = false)
