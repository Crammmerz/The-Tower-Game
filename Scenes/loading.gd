extends Node2D

@onready var anim = $Control/AnimatedSprite2D

func _ready():
	anim.play("loading")
	$Control/RichTextLabel.text = "[wave amp=300 freq=20]Loading...[/wave]"
