extends Area2D

signal hit_registered(target)

func _on_body_entered(target: Node2D) -> void:
	if target.has_method("take_damage") and target.is_in_group("Enemy"):
		emit_signal("hit_registered", target)
