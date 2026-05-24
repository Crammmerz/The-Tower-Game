extends Node2D

var def: AbilityDefinition
var entity: Node2D
var duration: float = 2.0

@onready var hitbox: Area2D = $Hitbox 
@onready var anim1 = $Anim1
@onready var anim2 = $Anim2

func _ready() -> void:
	deactivate()

func activate(host: Node2D, target_pos: Vector2, data: AbilityDefinition):
	def = data
	entity = host
	hitbox.faction = host.profile.faction
	
	global_position = target_pos
	
	visible = true
	
	anim2.play()
	anim2.visible = true
	await anim2.animation_finished
	anim2.visible = false
	hitbox.set_deferred("monitoring", true)
	hitbox.set_deferred("monitorable", true)
	
	anim1.play()
	anim1.visible = true
	await anim1.animation_finished
	anim1.visible = false
	deactivate()

func deactivate():
	visible = false
	hitbox.set_deferred("monitoring", false)
	hitbox.set_deferred("monitorable", false)
	global_position = Vector2(-9999, -9999)

func _on_hitbox_hit_registered(target: Node2D) -> void:
	var dmg = def.base_value
	if target.has_method("take_damage"):
		target.take_damage(dmg)
