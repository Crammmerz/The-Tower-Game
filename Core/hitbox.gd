extends Area2D

signal hit_registered(target)

var targets_in_range: Array[Node2D] = []
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
		
		if not targets_in_range.has(target):
			targets_in_range.append(target)
			
			hit_registered.emit(target)
			
			if tick != null and tick.is_stopped():
				tick.start()

func _on_area_exited(area: Area2D) -> void:
	if area is Hurtbox:
		var target = area.owner
		
		if targets_in_range.has(target):
			targets_in_range.erase(target)
		
		if targets_in_range.is_empty() and tick:
			tick.stop()

func _on_tick_timeout() -> void:
	for i in range(targets_in_range.size() - 1, -1, -1):
		var target = targets_in_range[i]
		
		if is_instance_valid(target):
			hit_registered.emit(target)
		else:
			targets_in_range.remove_at(i)
