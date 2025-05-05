extends CharacterBody2D

class_name GamePlayer;

@onready var game_manger: GameManager = %GameManger

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var totalLife = 5
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


var isHited = false
var isDie = false


func on_area_2d_body_exited(_body: Node2D) -> void:
	isHited = false
	pass
func _on_player_die_finished():
	isDie = false
	get_tree().reload_current_scene()
	
	pass
func _on_player_hit_finished():
	isHited = false
	if totalLife <= 0 :
		isDie = true
		animated_sprite.animation_finished.connect(_on_player_die_finished,CONNECT_ONE_SHOT)
		animated_sprite.play("die")
	pass
	
func on_area_2d_body_entered(_body: Node2D) -> void:
	if _body is EnemyWeapons :
		print("hit by EnemyWeapons")
	if _body is Slime:
		print("hit by slime")
	if isDie :
		return
	isHited = true
	
	_decrement_life()
	if totalLife >= 1 :
		animated_sprite.animation_finished.connect(_on_player_hit_finished,CONNECT_ONE_SHOT)
		animated_sprite.play("hit")
	else:
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		else:
			velocity.y = JUMP_VELOCITY * 2
		isDie = true
		animated_sprite.animation_finished.connect(_on_player_die_finished,CONNECT_ONE_SHOT)
		animated_sprite.play("die")
	pass
	


func _increment_life():
	pass
	
func _decrement_life():
	totalLife -= 1
	totalLife = max(0,totalLife)
	_update_life()
	pass
	

func _update_life():
	pass
	#if totalLife > 0:
		#life_label.text = str(totalLife) + " Life"
