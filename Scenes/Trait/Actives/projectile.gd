extends Node2D

@export var speed = 500
var def: AbilityDefinition
var body: Node2D

var direction = Vector2.ZERO
var duration: float = 2.0 
var current_time: float = 0.0
var hit_count = 0

@onready var hitbox: Area2D = $Hitbox 

func _ready() -> void:
	deactivate()

func _process(delta: float) -> void:
	position += direction * speed * delta
	
	current_time += delta
	if current_time >= duration:
		deactivate()

func activate(entity: Node2D, target_pos: Vector2, data: AbilityDefinition):
	def = data
	body = entity
	hitbox.faction = entity.profile.faction
	
	global_position = body.global_position
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

func _on_hitbox_hit_registered(target: Node2D) -> void:
	var dmg = def.base_value
	if target.has_method("take_damage"):
		target.take_damage(dmg)
		
		hit_count += 1
		var max_pierce = def.special_tags.get("pierce", 0)
		
		if hit_count > max_pierce:
			deactivate()
