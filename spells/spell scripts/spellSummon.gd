extends SpellBehaviour
class_name SummonBehavior

@export var summon_scene : PackedScene
@export var summon_pattern : SummonPattern

func cast(caster : Node3D):
		var summon: Summon = summon_scene.instantiate()
		summon.position = caster.to_global(caster.position)
		summon.position += Vector3.UP
		summon.rotation = Manager.player.rotation
		caster.get_tree().get_root().add_child(summon)
