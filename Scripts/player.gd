extends GamePlayer
	
@onready var life_label: Label = $Label
@onready var collision_shape: CollisionShape2D = $CollisionShape2D



func _update_life():
	if totalLife > 0:
		life_label.text = str(totalLife) + " Life"

func _ready() -> void:
	isDie = false
	_update_life()
	pass

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
