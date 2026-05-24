extends TextureButton

@onready var label = $Label
@onready var desc = $Description
@onready var img = $Image

func setup_card_display(card: CardData):
	label.text = card.card_name
	desc.text = card.card_description
	img.texture = card.card_icon
