extends Area3D
class_name Summon

@export var damage_player := true
@export var damage_enemies := false

@export var damage := 1.0
@export var speed := 10.0
@export var despawn_time := 5.0
	
func _on_collision(body: Node3D):
	if damage_player and body is Player: 
		body.take_damage(damage)
		queue_free()
	
	if body is Enemy:
		if damage_enemies:
			body.take_damage(damage, global_position, 0.0)
			queue_free()
	
