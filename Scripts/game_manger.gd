extends Node

class_name GameManager
@onready var label: Label = $Label

var currentPlayer:GamePlayer

var score = 0
func addScore(plusScore: int = 1):
	score += plusScore
	print("score:" + str(score))
	label.text = "干的漂亮\n你获得了"+ str(score) +"枚金币。"


func bindPlayer(player: GamePlayer):
	#currentPlayer.queue_free()
	#currentPlayer = null
	currentPlayer = player
	pass

func on_area_2d_body_entered(body: Node2D) -> void:
	currentPlayer.on_area_2d_body_entered(body)
	pass
func on_area_2d_body_exited(body: Node2D) -> void:
	currentPlayer.on_area_2d_body_exited(body)
	pass
