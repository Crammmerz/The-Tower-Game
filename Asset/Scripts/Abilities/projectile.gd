extends Node2D

@export var speed = 500
var def: AbilityDefinition
var direction = Vector2.ZERO
var duration: float = 2.0 
var current_time: float = 0.0
var base_damage = 0
var damage = 0
var hit_count = 0

@onready var hitbox: Area2D = $Hitbox 

func _process(delta: float) -> void:
	position += direction * speed * delta
	
	current_time += delta
	if current_time >= duration:
		deactivate()

func activate(target_pos: Vector2, data: AbilityDefinition):
	def = data
	var player = GameEvents.player
	if is_instance_valid(player):
		global_position = player.global_position
		direction = (target_pos - global_position).normalized()
		current_time = 0.0 
		visible = true
		set_process(true)
		hitbox.set_deferred("monitoring", true)
		hitbox.set_deferred("monitorable", true)

func deactivate():
	visible = false
	hit_count = 0
	set_process(false)
	set_physics_process(false)
	hitbox.set_deferred("monitoring", false)
	hitbox.set_deferred("monitorable", false)
	global_position = Vector2(-9999, -9999)

func _on_hitbox_hit_registered(target: Variant) -> void:
	hit_count += 1
	var max_pierce = def.special_tags.get("pierce",0)
	target.take_damage(def.special_tags.get("damage",0))
	if hit_count > max_pierce:
		deactivate()
