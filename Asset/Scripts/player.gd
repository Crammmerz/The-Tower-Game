extends CharacterBody2D

@onready var anim = $PlayerAnim
@export var move: bool = true

@export var stats: BaseStats
var enemy_in_range = []

func _ready() -> void:
	if stats:
		stats = stats.duplicate()
		print("Player Stats Initialization: Success")
	else:
		print("Player Stats Initialization: Failed")

func _physics_process(_delta: float) -> void:
	if !stats: return
	handle_movement_input()
	move_and_slide()
	update_animations()

func handle_movement_input() -> void:
	var input_direction = Vector2.ZERO
	
	if move:
		input_direction = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	velocity = input_direction * stats.move_speed

func update_animations() -> void:
	if velocity == Vector2.ZERO:
		anim.play("Idle")
	else:
		# Determine if we are moving more horizontally or vertically
		if abs(velocity.x) > abs(velocity.y):
			anim.play("Move_Right")
			anim.flip_h = velocity.x < 0
		else:
			if velocity.y < 0:
				anim.play("Move_Forward")
			else:
				# If you have a backward/down anim, play it here
				pass # anim.play("Move_Backward")
