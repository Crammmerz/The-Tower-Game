extends CharacterBody2D

@onready var anim = $PlayerAnim
const SPEED = 150.0

func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	
	if velocity == Vector2.ZERO:
		anim.play("Idle")
	if Input.is_action_pressed("move_forward"):
		input_vector.y -= 1
	if Input.is_action_pressed("move_backward"):
		input_vector.y += 1
	if Input.is_action_pressed("move_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("move_right"):
		input_vector.x += 1
	
	if input_vector == Vector2.ZERO:
		anim.play("Idle")
	else:
		if abs(input_vector.x) > abs(input_vector.y):
			anim.play("Move_Right")
			anim.flip_h = input_vector.x < 0
		else:
			if input_vector.y < 0:
				anim.play("Move_Forward")
			else:
				anim.play("Idle")
	
	input_vector = input_vector.normalized()
	velocity = input_vector * SPEED
	move_and_slide()
