extends CharacterBody2D

const GRAVITY : int = 3900
const JUMP_SPEED : int = -1200

func play_hurt_animation():
	$AnimatedSprite2D.play("hurt")
	
	
func _input(event):
	#checks for screen tap instead of space for jumping
	if event is InputEventScreenTouch and event.is_pressed():
		if is_on_floor():
			velocity.y = JUMP_SPEED
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.y += GRAVITY * delta
	if is_on_floor():
		if not get_parent().game_running:
			$AnimatedSprite2D.play("idle")
		else:
			$RunCol.disabled = false
			if Input.is_action_pressed("ui_accept"):
				velocity.y = JUMP_SPEED
				#$JumpSound.play()
			elif Input.is_action_pressed("ui_down"):
				$AnimatedSprite2D.play("duck")
				$RunCol.disabled = true
			else:
				$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("jump")
		
	move_and_slide()


