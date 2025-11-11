extends Control

func _ready():
	var tween = create_tween()
	tween.tween_property($TextEdit, "modulate:a", 0.0, 15)
	tween.finished.connect(func(): $TextEdit.visible = false)
