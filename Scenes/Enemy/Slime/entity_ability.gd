extends Node

@export var entity: CharacterBody2D
@export var data: AbilityDefinition

@onready var tick = $Timer

var current_target: Node2D = null

func _ready() -> void:
	tick.timeout.connect(_on_tick_timeout)
	tick.wait_time = data.cooldown
	tick.one_shot = false

func _on_detection_range_nearest_target_signal(nearest_target: Variant) -> void:
	if nearest_target == null:
		current_target = null
		tick.stop() # Turn off the clock if there are no enemies around to save CPU cycles
		return
	
	entity.set_physics_process(false)
	entity.anim.play("idle")
	current_target = nearest_target
	
	if tick.is_stopped():
		tick.start()

func _on_tick_timeout() -> void:
	if current_target:
		var obj = AbilityPoolManager.get_from_pool(data)
		if obj == null:
			print("null")
		else:
			obj.activate(entity,current_target.global_position, data)
	else:
		current_target = null
		entity.set_physics_process(true)
		tick.stop()
