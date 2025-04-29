extends CharacterBody2D
class_name GamePlayer;
	
@onready var game_manger: GameManager = %GameManger
@onready var life_label: Label = $Label

var isHited = false
@export var totalLife = 5
func on_area_2d_body_exited(body: Node2D) -> void:
	isHited = false
	pass
func on_area_2d_body_entered(body: Node2D) -> void:
	_decrement_life()
	isHited = true
	animated_sprite.play("hit")
	pass
func hited(value: int):
	print("hited")
	isHited = true
	animated_sprite.play("hit")
	pass
	
const SPEED = 130.0
const JUMP_VELOCITY = -300.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
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
	life_label.text = str(totalLife) + " Life"
	
func _process(delta: float) -> void:
	if  game_manger != null:
		game_manger.bindPlayer(self)

func _physics_process(delta):
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
