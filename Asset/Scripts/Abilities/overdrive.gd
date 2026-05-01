extends Node2D

var def: AbilityDefinition
var duration: float = 5.0
var current_time: float = 0.0
var cdr: float = 0.0
var base_value = 4.0

@onready var anim: AnimatedSprite2D = $Animation

func _process(delta: float) -> void:
	var player = GameEvents.player
	if is_instance_valid(player):
		global_position = player.global_position
	
	current_time += delta
	if current_time >= duration:
		deactivate()

func activate(_target_pos, data: AbilityDefinition):
	def = data
	var player = GameEvents.player
	if is_instance_valid(player):
		
		player.stats.cooldown_reduction += base_value
		cdr = base_value
		current_time = 0.0 
		
		visible = true
		set_process(true)
		anim.play()

func deactivate():
	var player = GameEvents.player
	if is_instance_valid(player):
		player.stats.cooldown_reduction -= cdr
		visible = false
		set_process(false)
		global_position = Vector2(-9999, -9999)
