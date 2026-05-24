class_name StatCardData extends CardData

# A list of the stats from your script we want to allow upgrades for
enum TargetStat { 
	MAX_HEALTH, 
	HP_REGEN, 
	MOVE_SPEED, 
	STRENGTH, 
	DEFENSE,
	HP_MODIFIER,
	STR_MODIFIER,
	CD_REDUCTION
}

@export var stat_to_upgrade: TargetStat
@export var change_value: float = 0.0 # Can be positive (buff) or negative (debuff)

func apply_effect() -> void:
	var prof = GameEvents.player.profile
	match stat_to_upgrade:
		TargetStat.MAX_HEALTH:
			prof.max_health += change_value
			prof.current_hp += change_value
		TargetStat.HP_REGEN:
			prof.hp_regen_amount += change_value
		TargetStat.MOVE_SPEED:
			prof.move_speed += change_value
		TargetStat.STRENGTH:
			prof.strength += change_value
		TargetStat.DEFENSE:
			prof.defense += change_value
		# Modifiers
		TargetStat.HP_MODIFIER:
			prof.hp_modifier += change_value
		TargetStat.STR_MODIFIER:
			prof.str_modifier += change_value
		TargetStat.CD_REDUCTION:
			prof.cd_reduction += change_value
	# Critically important: Force your recalculation method to run!
	if prof.has_method("recalc_stats"):
		prof.recalc_stats()
