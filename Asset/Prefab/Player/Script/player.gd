extends CharacterBody2D

@onready var anim = $PlayerAnim
@export var stats: BaseStats

func _ready() -> void:
	if stats:
		stats = stats.duplicate()
		GameEvents.register_player(self)

func _physics_process(_delta: float) -> void:
	handle_movement_input()
	move_and_slide()
	update_animations()

func handle_movement_input() -> void:
	if not stats: return
	var input_direction = Vector2.ZERO
	
	input_direction = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	velocity = input_direction * stats.move_speed

func update_animations() -> void:
	if not stats and stats.move: return
	if velocity == Vector2.ZERO:
		anim.play("Idle")
	else:
		if abs(velocity.x) > abs(velocity.y):
			anim.play("Move_Right")
			anim.flip_h = velocity.x < 0
		else:
			if velocity.y < 0:
				anim.play("Move_Forward")
			else:
				# If you have a backward/down anim, play it here
				pass # anim.play("Move_Backward")
