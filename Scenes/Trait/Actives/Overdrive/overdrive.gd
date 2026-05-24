extends Node2D

var def: AbilityDefinition
var unit: Node2D
var duration: float = 5.0
var current_time: float = 0.0
var cdr: float = 0.0
var base_value = 4.0

@onready var anim: AnimatedSprite2D = $Animation
@onready var main = get_tree().current_scene

func _ready() -> void:
	visible = false
	set_process(false)
	global_position = Vector2(-9999, -9999)

func _process(delta: float) -> void:
	if not is_instance_valid(unit):
		visible = false
		set_process(false)
		return
		
	global_position = unit.global_position
	
	current_time += delta
	if current_time >= duration:
		deactivate()

func activate(entity: Node2D,_target_pos, data: AbilityDefinition):
	def = data
	unit = entity
	unit.profile.cd_reduction += base_value
	cdr = base_value
	current_time = 0.0 
	
	visible = true
	set_process(true)
	anim.play()

func deactivate():
	unit.profile.cd_reduction -= cdr
	visible = false
	set_process(false)
	global_position = Vector2(-9999, -9999)
