extends CharacterBody2D

@onready var anim = $Animation
@export var profile: EntityDefinition

func _ready() -> void:
	if profile:
		profile = profile.duplicate()
		GameEvents.register_player(self)
		self.set_physics_process(false)

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
	if profile.is_immune: return
	var total_def = profile.defense * profile.def_modifier
	var reduction = total_def / (total_def + 100.0)
	var final_damage = value * (1.0 - reduction)
	
	profile.current_hp -= final_damage
	
	GameEvents.player_damaged.emit(profile.current_hp,profile.max_health)
	flash_hit_effect()
	if profile.current_hp <= 0:
		print(profile.current_hp)
		GameEvents.player_died.emit()

func flash_hit_effect():
	var tween = create_tween()
	tween.tween_property(anim, "modulate", Color(1, 0, 0, 0.2), 0.1)
	tween.tween_property(anim, "modulate", Color(1, 1, 1, 1.0), 0.1)

func get_faction(): return "player"
