extends Area2D
class_name Weapons;
@export var weapons_tag = "Weapons"
var game_manger: GameManager


func tryBindGameManager(gameManager: GameManager) -> void:
	self.game_manger = gameManager
