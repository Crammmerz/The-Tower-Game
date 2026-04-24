extends Area2D

@export var speed = 800
var direction = Vector2.ZERO
var lifetime: float = 2.0 
var current_time: float = 0.0
var damage = 0

func _process(delta: float) -> void:
	position += direction * speed * delta
	
	# Timer-based deactivation
	current_time += delta
	if current_time >= lifetime:
		deactivate()

func activate(source_node: Node2D, target_pos: Vector2, dmg):
	if source_node == null:
		push_error("Projectile activated without a source!")
		return
	
	global_position = source_node.global_position
	direction = (target_pos - global_position).normalized()
	damage = dmg
	current_time = 0.0 
	visible = true
	set_process(true)
	
	if self is Area2D:
		monitoring = true
		monitorable = true

func deactivate():
	visible = false
	set_process(false)
	monitoring = false
	monitorable = false
	global_position = Vector2(-9999, -9999)

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage") and body.is_in_group("Enemy"):
		body.take_damage(damage)
		deactivate()
