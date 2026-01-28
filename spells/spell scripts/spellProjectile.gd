extends SpellBehaviour
class_name ProjectileBehaviour

@export var projectile_scene : PackedScene
@export var projectile_pattern : ProjectilePattern

func cast(caster : Node3D):
	var projectile: Projectile = projectile_scene.instantiate()
	projectile.position = caster.to_global(caster.position)
	projectile.position += Vector3.UP
	projectile.rotation = Manager.player.rotation # I know this rotation shit is kinda ass but I'm not smart - Ethan Hansen (1/27/26)
	caster.get_tree().get_root().add_child(projectile)

	
