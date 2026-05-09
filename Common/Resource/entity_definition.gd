extends Resource
class_name EntityDefinition

@export var species: String = "player"
@export var faction: String = "enemy"
@export var can_move: bool = true
@export var exp_value: int = 10

@export_group("Health")
@export var max_health: float = 100.0
@export var hp_regen_amount: float = 0.0

@export_group("Movement & Combat")
@export var move_speed: float = 0.0
@export var strength: float = 10.0
@export var defense: float = 0.0

@export_group("Modifiers")
@export var hp_modifier: float = 1.0
@export var hp_regen_modifier: float = 1.0
@export var move_speed_modifier: float = 1.0
@export var str_modifier: float = 1.0
@export var def_modifier: float = 1.0
@export var cd_reduction: float = 1.0
