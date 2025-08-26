class_name WeaponHitbox
extends Area3D

@export var damage := 10.0
@export var knockback := 10.0

func _ready():
	connect("body_entered", _on_hitbox_body_entered)
	connect("area_entered", _on_hitbox_area_entered)
 
func _on_hitbox_body_entered(body):
	if body is Enemy:
		body.take_damage(damage, Manager.player.global_position, knockback)

func _on_hitbox_area_entered(area):
	if area is Interactable:
		if area.damage_activated: area.interact(false)
