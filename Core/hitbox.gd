extends Area2D

signal hit_registered(target)
var current_target: Node2D = null
var faction: String
var tick: Timer

func _ready() -> void:
	if get_parent().has_method("get_faction"):
		faction = get_parent().get_faction()
	
	if has_node("DamageTimer"):
		tick = $DamageTimer
		tick.timeout.connect(_on_tick_timeout)
	
	

func _on_area_entered(area: Area2D) -> void:
	if area is Hurtbox:
		var target = area.owner
		if target.has_method("get_faction") and target.get_faction() == faction:
			return
		
		current_target = target
		if tick != null:
			tick.start()
		
		hit_registered.emit(area.owner)

func _on_area_exited(area: Area2D) -> void:
	if current_target and area.owner == current_target:
		if tick:
			tick.stop()
		current_target = null

func _on_tick_timeout() -> void:
	if current_target:
		hit_registered.emit(current_target)
