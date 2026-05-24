extends Node

# Drag your full collections of custom .tres resource files here in the Inspector
@export var available_actives: Array[Resource] = []   # ActiveAbilityCard pool
@export var available_passives: Array[Resource] = []  # PassiveAbilityCard pool
@export var available_stats: Array[Resource] = []     # StatCardData pool

## Generates 3 unique random choices for the upgrade display panel
func generate_card_choices() -> Array[Resource]:
	var current_choices: Array[Resource] = []
	
	# 1. Build a single temporary candidate pool for this specific draw
	var temp_pool: Array[Resource] = []
	temp_pool.append_array(available_actives)
	temp_pool.append_array(available_passives)
	temp_pool.append_array(available_stats)
	
	# 2. Draw cards until we fill our 3 slots (or run out of cards completely)
	while current_choices.size() < 3 and not temp_pool.is_empty():
		var chosen_card = _pick_card_by_weight(temp_pool)
		
		if chosen_card:
			current_choices.append(chosen_card)
			# Prevent drawing the same exact card resource multiple times in ONE choice screen
			temp_pool.erase(chosen_card)
			
	return current_choices

func _pick_card_by_weight(pool: Array[Resource]) -> Resource:
	if pool.is_empty(): 
		return null
		
	var total_weight: float = 0.0
	for card in pool:
		total_weight += card.weight if "weight" in card else 10.0
		
	var roll = randf_range(0.0, total_weight)
	var current_sum: float = 0.0
	
	for card in pool:
		current_sum += card.weight if "weight" in card else 10.0
		if roll <= current_sum:
			return card
			
	return pool.pick_random()

## CALL THIS FUNCTION when the player confirms their selection!
func remove_chosen_card_from_deck(chosen_card: Resource) -> void:
	chosen_card.apply_effect()
	if chosen_card is ActiveAbilityCard:
		available_actives.erase(chosen_card)
		print("Purged Active Ability from deck permanently: ", chosen_card.resource_path.get_file())
		
	elif chosen_card is PassiveAbilityCard:
		available_passives.erase(chosen_card)
		print("Purged Passive Ability from deck permanently: ", chosen_card.resource_path.get_file())
		
	elif chosen_card is StatCardData:
		# Stat cards are infinite! We do not erase them from the deck master list.
		print("Stat upgrade retained in pool: ", chosen_card.resource_path.get_file())
