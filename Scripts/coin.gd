extends Area2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var game_manger: GameManager = %GameManger
@export var defaultScore = 1

func _on_body_entered(_body: Node2D) -> void:
	game_manger.addScore(defaultScore)
	animation_player.play("pickup")
	pass # Replace with function body.
