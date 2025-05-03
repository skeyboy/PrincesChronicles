extends AnimatableBody2D
@onready var sprite_2d: Sprite2D = $Sprite2D

@export var platform_type = 0

@export var platform_height = 16

@export var platform_width = 32

@export var offsetX = 16

func _ready() -> void:
	sprite_2d.region_enabled  = true
	sprite_2d.region_rect = Rect2(offsetX,platform_type * platform_height,platform_width,platform_height)
	pass
