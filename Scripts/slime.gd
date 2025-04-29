extends Node2D

@onready var ray_cast_left: RayCast2D = $RayCast2DLeft
@onready var ray_cast_right: RayCast2D = $RayCast2DRight
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var game_manger: GameManager = %GameManger

const SPEED = 60

var direction = 1


	
func _process(delta):
	
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
		
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	
	position.x += direction * SPEED * delta
	
	#print("postion:  "+ str(position.x))


func _on_area_2d_body_entered(body: Node2D) -> void:
	game_manger.on_area_2d_body_entered(body)
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	game_manger.on_area_2d_body_exited(body)
	pass # Replace with function body.
