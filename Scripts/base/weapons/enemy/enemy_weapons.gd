extends Weapons

class_name  EnemyWeapons;

var direction
@export var horizontal_speed = 20
@export var vertical_speed = 0
func _init() -> void:
	weapons_tag = "EnemyWeapons"
	self.body_entered.connect(on_body_entered)
func on_body_entered(body: Node2D) -> void:
	pass
