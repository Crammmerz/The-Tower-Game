extends Node
class_name AttributeDefinition

enum STAT_TYPE {
	MAX_HP, MAX_HP_MOD, 
	HP_REGEN, HP_REGEN_MOD,
	STR, STR_MOD,
	DEF, DEF_MOD,
	CD_REDUCTION
	}

@export var type: STAT_TYPE
@export var value: float
