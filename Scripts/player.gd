extends CharacterBody2D
class_name GamePlayer;
	
@onready var game_manger: GameManager = %GameManger
@onready var life_label: Label = $Label
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

var isHited = false
var isDie = false

@export var totalLife = 5
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
	
const SPEED = 130.0
const JUMP_VELOCITY = -300.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	isDie = false
	_update_life()
	pass

func _increment_life():
	pass
	
func _decrement_life():
	totalLife -= 1
	totalLife = max(0,totalLife)
	_update_life()
	pass
	
func _update_life():
	if totalLife > 0:
		life_label.text = str(totalLife) + " Life"
	
func _process(_delta: float) -> void:
	if  game_manger != null:
		game_manger.bindPlayer(self)

func _physics_process(delta):
	if isDie:
		return;
	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")
	
	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	if is_on_floor():
		if direction == 0:
			if isHited:
				animated_sprite.play("hit")
			else:
				animated_sprite.play("idle")
		else:
			if isHited :
				isHited = false
			animated_sprite.play("run")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

	pass
