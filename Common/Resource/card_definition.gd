extends Resource
class_name CardData

@export var card_name: String
@export_multiline var card_description: String
@export var card_icon: Texture
@export var weight: int = 10 # Higher weight = more common in RNG

func apply_effect() -> void:
	pass
