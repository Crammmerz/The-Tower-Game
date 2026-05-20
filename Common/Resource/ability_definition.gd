extends Resource
class_name AbilityDefinition

@export_group("Identity")
@export var name: String = "New Skill"
@export_multiline var description: String


@export_group("Stats")
@export var base_value: float
@export var cooldown: float

@export_group("System Settings")
@export var scene: PackedScene
@export var pool_size: int = 20

@export_group("Unique Tags")
@export var special_tags: Dictionary = {
	"require_target": true
}
