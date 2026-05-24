extends Control

@export var card_pool_manager: Node

@export var card1: TextureButton
@export var card2: TextureButton
@export var card3: TextureButton

var current_options: Array[Resource] = []

func _ready():
	GameEvents.player_leveled_up.connect(display_ui)
	card1.pressed.connect(func(): _on_card_chosen(0))
	card2.pressed.connect(func(): _on_card_chosen(1))
	card3.pressed.connect(func(): _on_card_chosen(2))
	hide()

func display_ui(_num):
	current_options = card_pool_manager.generate_card_choices()
	
	card1.setup_card_display(current_options[0])
	card2.setup_card_display(current_options[1])
	card3.setup_card_display(current_options[2])
	
	show()
	get_tree().paused = true

func _on_card_chosen(index: int) -> void:
	if index >= current_options.size():
		return
		
	var chosen_card = current_options[index]
	
	if card_pool_manager and card_pool_manager.has_method("remove_chosen_card_from_deck"):
		card_pool_manager.remove_chosen_card_from_deck(chosen_card)
	
	current_options.clear()
	hide()
	get_tree().paused = false
