extends Resource
class_name BaseStats

@export_group("Health")
@export var max_health: float = 100.0
@export var hp_regen_amount: float = 1.0
@export var hp_regen_rate: float = 0.0
@export var hp_regen_delay: float = 3.0
@export var hp_regen_per_wave: float = 10.0

@export_group("Movement & Combat")
@export var move_speed: float = 0.0
@export var strength: float = 10.0
@export var defense: float = 0.0

@export_group("Modifiers")
@export var hp_regen_modifier: float = 1.0
@export var move_speed_modifier: float = 1.0
@export var attack_modifier: float = 1.0
@export var defense_modifier: float = 1.0
@export var cooldown_reduction: float = 1.0

@export_group("Progression")
@export var experience_points: int = 0
@export var level: int = 1
