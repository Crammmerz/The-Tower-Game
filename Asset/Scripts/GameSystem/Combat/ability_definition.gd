extends Resource
class_name AbilityDefinition

@export var name: String
@export var description: String
@export var require_target: bool = true
@export var base_value: float
@export var cooldown: float
@export var pool_size: int = 20
@export var scene: PackedScene

var cooldown_timer: float = 0.0
var pool: Array = []

func initialize_pool(container: Node):
	if not scene: return
	
	for i in range(pool_size):
		var inst = scene.instantiate()
		inst.visible = false
		inst.set_process(false)
		container.add_child(inst)
		pool.append(inst)

func get_from_pool():
	for obj in pool:
		if not obj.visible:
			return obj
	return null

func can_activate() -> bool:
	return cooldown_timer <=0

func activate():
	if can_activate():
		cooldown_timer = cooldown

func tick(delta: float):
	if cooldown_timer > 0.0:
		cooldown_timer -= delta
