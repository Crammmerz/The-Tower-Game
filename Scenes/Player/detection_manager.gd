extends Area2D

signal nearest_target_signal(nearest_target)

@export var faction: String = "enemy"

var targets_in_range: Array[Node2D] = []
var nearest_target: Node2D = null

func _process(_delta: float) -> void:
	targets_in_range = targets_in_range.filter(func(t): return is_instance_valid(t))
	
	var new_target = get_nearest_target(global_position)
	if new_target != nearest_target:
		nearest_target = new_target
		nearest_target_signal.emit(nearest_target)

func _on_area_entered(area: Area2D) -> void:
	if area is Hurtbox:
		var body: Node2D = area.get_parent()
		if not targets_in_range.has(body):
			if body.has_method("get_faction") and body.get_faction() != faction:
				targets_in_range.append(body)

func _on_area_exited(area: Area2D) -> void:
	if area is Hurtbox:
		var body = area.get_parent()
		if body in targets_in_range:
			targets_in_range.erase(body)

func get_nearest_target(origin: Vector2) -> Node2D:
	if targets_in_range.is_empty():
		return null
	
	var nearest = null
	var min_dist = INF
	
	for t in targets_in_range:
		if is_instance_valid(t):
			var dist = origin.distance_to(t.global_position)
			if dist < min_dist:
				min_dist = dist
				nearest = t
	
	return nearest
