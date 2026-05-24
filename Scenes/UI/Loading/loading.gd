extends Control

@onready var anim = $AnimatedSprite2D

func _ready():
	anim.play("loading")
	$RichTextLabel.text = "[wave amp=300 freq=20]Loading...[/wave]"
	GameEvents.loading_complete.connect(hide)
