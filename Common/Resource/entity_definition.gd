extends Resource
class_name EntityDefinition

@export_group("Identity")
@export var species: String = "player"
@export var faction: String = "enemy"

@export_group("Progression")
@export var exp_value: float = 10

@export_group("Health")
@export var max_health: float = 100.0
@export var hp_regen_amount: float = 0.0

@export_group("Movement")
@export var move_speed: float = 0.0
@export var can_move: bool = true

@export_group("Combat")
@export var strength: float = 10.0
@export var defense: float = 0.0

@export_group("Modifiers")
@export var hp_modifier: float = 1.0
@export var hp_regen_modifier: float = 1.0
@export var move_speed_modifier: float = 1.0
@export var str_modifier: float = 1.0
@export var def_modifier: float = 1.0
@export var cd_reduction: float = 1.0

var is_immune: bool = false
var total_max_hp: float = 0.0
var total_str: float = 0.0
var current_hp: float = 0.0

func recalc_stats():
	var past_hp = max_health
	total_max_hp = max_health * hp_modifier
	current_hp = total_max_hp - past_hp
