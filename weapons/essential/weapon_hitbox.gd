class_name WeaponHitbox
extends Area3D

@export var damage := 10.0

func _ready():
	connect("body_entered", self._on_hitbox_body_entered)

func _on_hitbox_body_entered(body):
	if body.is_in_group("Damageable"):
		if body.has_method("take_damage"): 
			body.take_damage(damage)
