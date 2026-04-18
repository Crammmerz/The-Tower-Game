extends Sprite2D

@export var follow_speed: float = 5.0
@export var player: Node2D # Assign your Player node here in the Inspector
var active_target: Node2D = null

func _process(delta: float) -> void:
	var target_pos: Vector2
	
	if active_target != null and is_instance_valid(active_target):
		visible = true
		target_pos = Vector2(active_target.global_position.x, 20 + active_target.global_position.y)
	else:
		visible = false
		target_pos = player.global_position + Vector2(0, 20)
	
	global_position = global_position.lerp(target_pos, follow_speed * delta)

func _on_detection_range_nearest_target_signal(nearest_target: Variant) -> void:
	active_target = nearest_target
