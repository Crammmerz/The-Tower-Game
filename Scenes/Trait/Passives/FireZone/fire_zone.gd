extends Node2D

@export var base_fire_damage: float = 5.0
@export var strength_scaling_factor: float = 0.05

@onready var hitbox: Area2D = $Hitbox 

var entity

func activate(host: Node2D):
	if host and host.has_node("HurtBox"):
		entity = host
		hitbox.faction = entity.profile.faction
	if get_parent() != host:
		reparent(host, true) 

func _on_area_2d_hit_registered(target: Variant) -> void:
	if not entity or not entity.get("profile"):
		return
		
	var prof = entity.profile
	
	var total_strength = prof.strength * prof.str_modifier
	var final_damage = (base_fire_damage + (total_strength * strength_scaling_factor))
	
	final_damage = round(final_damage)

	if target.has_method("take_damage"):
		target.take_damage(final_damage)
	elif target.get("profile") and "current_hp" in target.profile:
		target.profile.current_hp -= final_damage
