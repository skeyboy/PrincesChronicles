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
	if Input.is_action_just_pressed("fire"):
		var direction = 1
		if animated_sprite.is_flipped_h():
			direction = -1
		var fireball = preload("res://Scripts/enemy_weapons/fireball.tscn").instantiate() as Fireball
		fireball.setParentSpeed(SPEED)
		fireball.vertical_speed = 80
		fireball.direction = direction

		# fireball 再角色前方一定距离
		fireball.global_position = Vector2(global_position.x + 16 * direction,global_position.y)
		get_tree().root.add_child(fireball)
		fireball.tryBindGameManager( game_manger)
		
		pass

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
