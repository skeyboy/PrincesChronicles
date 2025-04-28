extends Node

class_name GameManager
@onready var label: Label = $Label

var score = 0
func addScore(plusScore: int = 1):
	score += plusScore
	print("score:" + str(score))
	label.text = "干的漂亮\n你获得了"+ str(score) +"枚金币。"
