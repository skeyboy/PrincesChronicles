extends Node2D
class_name  Slime;

@onready var ray_cast_left: RayCast2D = $RayCast2DLeft
@onready var ray_cast_right: RayCast2D = $RayCast2DRight
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var game_manger: GameManager = %GameManger
@onready var FIREBALL = preload("res://Scripts/enemy_weapons/fireball.tscn")
@onready var shooting_point: Marker2D = $Marker2D

const SPEED = 60

var direction = 1


func _ready() -> void:
	
	pass
	
func _process(delta):
	
	if ray_cast_right.is_colliding():
		direction = -1
		_create_fireball()
		animated_sprite.flip_h = true
		
		
		
	if ray_cast_left.is_colliding():
		direction = 1
		_create_fireball()
		animated_sprite.flip_h = false
		
	
	position.x += direction * SPEED * delta
	
#	 创建 武器
func _create_fireball() -> void:
	var fireball = FIREBALL.instantiate() as Fireball
	fireball.setParentSpeed(SPEED)
	fireball.direction = direction
	# fireball 再角色前方一定距离
	fireball.global_position = Vector2(shooting_point.global_position.x + 32 * direction,shooting_point.global_position.y)
	get_tree().root.add_child(fireball)
	fireball.tryBindGameManager( game_manger)
	pass
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	game_manger.on_area_2d_body_entered(body)
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	game_manger.on_area_2d_body_exited(body)
	pass # Replace with function body.
