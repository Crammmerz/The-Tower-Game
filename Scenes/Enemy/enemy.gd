extends CharacterBody2D

@export var profile: EntityDefinition

@onready var anim = $Animation
@onready var hitbox = $Hitbox
@onready var hurtbox = $HurtBox

func _ready() -> void:
	deactivate()

func _physics_process(_delta: float) -> void:
	var player = GameEvents.player
	
	if is_instance_valid(player):
		var direction = global_position.direction_to(player.global_position)
		
		velocity = direction * profile.move_speed
		
	else:
		velocity = Vector2.ZERO
	move_and_slide()

func scale_stats():
	var wave = GameEvents.current_wave
	
	var hp_factor = 1.0 + (profile.hp_modifier * (wave - 5))
	var str_factor = 1.0 + (profile.str_modifier * (wave - 5))
	
	profile.total_max_hp = round(profile.max_health * hp_factor)
	profile.total_str = round(profile.strength * str_factor)
	profile.current_hp = profile.total_max_hp

func activate(summon_pos: Vector2):
	global_position = summon_pos
	scale_stats()
	
	visible = true
	set_process(true)
	set_physics_process(true)
	
	hurtbox.set_deferred("monitorable", true)
	hurtbox.set_deferred("monitoring", true)
	hitbox.set_deferred("monitoring", true)
	hitbox.set_deferred("monitorable", true)
	
	anim.play("walk")

func deactivate():
	set_process(false)
	set_physics_process(false)
	
	hurtbox.set_deferred("monitorable", false)
	hurtbox.set_deferred("monitoring", false)
	hitbox.set_deferred("monitoring", false)
	hitbox.set_deferred("monitorable", false)
	
	anim.play("die")
	await anim.animation_finished
	
	visible = false
	global_position = Vector2(-9999, -9999)

func take_damage(amount: float) -> void:
	if profile.is_immune: return
	var total_def = profile.defense * profile.def_modifier
	var reduction = total_def / (total_def + 100.0)
	var final_damage = amount * (1.0 - reduction)
	profile.current_hp -= final_damage
	
	flash_hit_effect()
	
	if profile.current_hp <= 0:
		die()

func flash_hit_effect():
	var tween = create_tween()
	tween.tween_property(anim, "modulate", Color.RED, 0.1)
	tween.tween_property(anim, "modulate", Color.WHITE, 0.1)

func die() -> void:
	GameEvents.enemy_died.emit(self)
	deactivate()

func get_faction(): return "enemy"

func _on_hitbox_hit_registered(target: Node2D) -> void:
	if target.has_method("take_damage"):
		target.take_damage(profile.total_str)
