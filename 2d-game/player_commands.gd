extends Control

func _ready():
	var tween = create_tween()
	tween.tween_property($TextEdit, "modulate:a", 0.0, 5)
	tween.finished.connect(func(): $TextEdit.visible = false)

#func change_text(message: String):
	#$TextEdit.text = message
