extends Node2D

@onready var anim = $Anim
@onready var hurtbox = $HurtBox

var current_hp = 100.0
var max_hp = 100.0

# Store a reference to the actual shape node inside the host's hurtbox
var entity: Node2D = null

func _ready() -> void:
	GameEvents.wave_started.connect(regen)

func activate():
	entity = get_parent()
	entity.profile.is_immune = true
		
	self.visible = true
	anim.play("active")

func regen(wave):
	max_hp = 100.0 * (1.0 + (wave * 0.1))
	current_hp = min(max_hp, current_hp + 25.0)
	
	if entity and entity.get("profile"):
		entity.profile.is_immune = true
	
	hurtbox.set_deferred("monitorable", true)
	self.visible = true
	anim.play("active")
	print("regen: ", current_hp, "/", max_hp)

func take_damage(value) -> void:
	if current_hp <= 0: return
	
	current_hp -= max(0, value)
	flash_hit_effect()
	
	if current_hp <= 0:
		current_hp = 0
		
		entity.profile.is_immune = false
		
		hurtbox.set_deferred("monitorable", false)
		anim.play("destroyed")
		
		await anim.animation_finished
		self.visible = false

func flash_hit_effect():
	var tween = create_tween()
	tween.tween_property(anim, "modulate", Color(1, 0, 0, 1.0), 0.1)
	tween.tween_property(anim, "modulate", Color(1, 1, 1, 1.0), 0.1)

func get_faction(): return "player"
