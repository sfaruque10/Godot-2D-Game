extends StaticBody2D

@onready var platform_sprite: Sprite2D = $Sprite2D
@onready var platform_collision_shape: CollisionShape2D = $CollisionShape2D
@onready var detection_area: Area2D = $Area2D
@onready var disappear_timer: Timer = $Timer
@onready var reappear_timer: Timer = $Timer2 

var player_on_platform: bool = false
var is_broken: bool = false
const FADE_DURATION: float = 0.5

var current_fade_tween: Tween = null

func _ready():
	#detection_area.body_entered.connect(_on_area_2d_body_entered)
	#detection_area.body_exited.connect(_on_area_2d_body_exited)
	disappear_timer.timeout.connect(_on_disappear_timer_timeout)
	reappear_timer.timeout.connect(_on_reappear_timer_timeout)
	
	# sprite starts fully opaque
	platform_sprite.modulate = Color(1, 1, 1, 1)

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
		
		fade_sprite(0.0) # start fading out
		
		# disable collision immediately
		platform_collision_shape.disabled = true
		
		reappear_timer.start() # start the wait time for coming back


func _on_reappear_timer_timeout():
	is_broken = false
	
	# enable collision shape before the fade finishes
	platform_collision_shape.disabled = false
	
	fade_sprite(1.0) # start fading in
	

func fade_sprite(target_alpha: float):	
	# kill any existing fade tween on this object before starting a new one
	if current_fade_tween != null and current_fade_tween.is_valid():
		current_fade_tween.kill()
		
	# create a new tween bound to this node (the StaticBody2D)
	current_fade_tween = create_tween()
	
	# tween the 'modulate:a' property of the Sprite2D
	current_fade_tween.tween_property(
		platform_sprite, 
		"modulate:a", 
		target_alpha, 
		FADE_DURATION
	)
	
