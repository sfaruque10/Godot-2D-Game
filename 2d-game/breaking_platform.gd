extends StaticBody2D

@onready var platform_sprite: Sprite2D = $Sprite2D
@onready var platform_collision_shape: CollisionShape2D = $CollisionShape2D
@onready var detection_area: Area2D = $Area2D
@onready var disappear_timer: Timer = $Timer
@onready var reappear_timer: Timer = $Timer2 # The new second timer

var player_on_platform: bool = false
var is_broken: bool = false

func _ready():
	#detection_area.body_entered.connect(_on_area_2d_body_entered)
	#detection_area.body_exited.connect(_on_area_2d_body_exited)
	disappear_timer.timeout.connect(_on_disappear_timer_timeout)
	reappear_timer.timeout.connect(_on_reappear_timer_timeout) # Connect the new timer's timeout

func _on_area_2d_body_entered(body: Node2D) -> void:
	if not is_broken and body.name == "Player":
		player_on_platform = true
		disappear_timer.start()
		print("standing")


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_on_platform = false
	if not is_broken:
		disappear_timer.stop()
		
		
		
func _on_disappear_timer_timeout():
	if player_on_platform:
		is_broken = true
		platform_collision_shape.disabled = true
		platform_sprite.visible = false
		reappear_timer.start()
		
func _on_reappear_timer_timeout():
	is_broken = false
	platform_collision_shape.disabled = false
	platform_sprite.visible = true
	
