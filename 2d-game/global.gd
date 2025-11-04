extends Node

var gravity_direction = 1 # normal gravity or flipped gravity
var has_dash = false #Player does not have immediate access to dash
var max_dashes = 1
var max_jumps = 1

#func change_text(message: String):
	#$PlayerCommands/TextEdit.text = message
