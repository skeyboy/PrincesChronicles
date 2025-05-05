extends Weapons

class_name  EnemyWeapons;

var direction
@export var horizontal_speed = 20
@export var vertical_speed = 0
func _init() -> void:
	weapons_tag = "EnemyWeapons"
	self.area_entered.connect(on_area_entered)
	self.body_entered.connect(on_body_entered)
func on_area_entered(area: Area2D):
	pass
func on_body_entered(body: Node2D) -> void:
	pass
