extends EnemyWeapons

class_name Fireball;

@onready var ray_cast_2d = $RayCast2D

func _process(delta):
	position.x += delta * horizontal_speed * direction
	position.y += delta * vertical_speed * direction

func setParentSpeed(speed) -> void:
	self.horizontal_speed += speed
	
func on_body_entered(body: Node2D) -> void:
	if body is GamePlayer:
		print(str(game_manger))
		game_manger.on_area_2d_body_entered(self)
		print("Player _on_body_entered")
	print(weapons_tag + " on_body_entered and will free")
	queue_free()
	pass # Replace with function body.
