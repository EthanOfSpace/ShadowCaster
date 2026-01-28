extends Resource
class_name SpellStrategy

@export var spell_behavior : SpellBehaviour
@export var cost : float

func cast(game_object: Node3D):
	spell_behavior.cast(game_object)
