extends Node

var current_xp: int = 0
var level: int = 1
var xp_to_next_level: int = 100

func _ready() -> void:
	GameEvents.enemy_died.connect(_on_enemy_died)

func _on_enemy_died(enemy):
	gain_xp(enemy.profile.exp_value)

func gain_xp(amount: int):
	current_xp += amount
	
	if current_xp >= xp_to_next_level:
		level_up()

func level_up():
	level += 1
	current_xp = 0
	xp_to_next_level *= 1.2
	
	GameEvents.player_leveled_up.emit(level)
	print("LEVEL UP! Current Level: ", level)
