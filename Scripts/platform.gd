extends AnimatableBody2D
@onready var timer: Timer = $Timer

@onready var collision_shape: CollisionShape2D = $CollisionShape2D

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var platform_type = 0

@export var platform_height = 10

@export var platform_width = 32

@export var offsetX = 16
@export var offsetY = 6

@export var can_jump_down = false


func _ready() -> void:
	sprite_2d.region_rect = Rect2(offsetX, (platform_height + offsetY) * platform_type, platform_width, platform_height )
	pass
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("move_down") and can_jump_down :
		set_collision_layer_value(1,false)		
		timer.start(0.25)
	pass


func _on_timer_timeout() -> void:
	set_collision_layer_value(1,true)
	pass # Replace with function body.
