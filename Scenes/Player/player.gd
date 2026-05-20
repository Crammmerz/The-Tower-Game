extends CharacterBody2D

@onready var anim = $Animation
@export var profile: EntityDefinition

func _ready() -> void:
	if profile:
		profile = profile.duplicate()
		GameEvents.register_player(self)

func _physics_process(_delta: float) -> void:
	handle_movement_input()
	move_and_slide()
	update_animations()

func handle_movement_input() -> void:
	var input_direction = Vector2.ZERO
	
	input_direction = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	velocity = input_direction * profile.move_speed

func update_animations() -> void:
	if not profile: return
	if velocity == Vector2.ZERO:
		anim.play("Idle")
	else:
		anim.play("Move")

func take_damage(value) -> void:
	profile.current_hp -= value
	flash_hit_effect()
	if profile.current_hp <= 0:
		pass

func flash_hit_effect():
	var tween = create_tween()
	tween.tween_property(anim, "modulate", Color(1, 0, 0, 0.2), 0.1)
	tween.tween_property(anim, "modulate", Color(1, 1, 1, 1.0), 0.1)

func get_faction(): return "player"
