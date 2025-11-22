extends Area3D
class_name Projectile

@export var damage_player := true
@export var damage_enemies := false

@export var damage := 1.0
@export var speed := 10.0
@export var despawn_time := 5.0

func _ready() -> void:
	connect("body_entered", _on_collision)
	await get_tree().create_timer(despawn_time).timeout
	queue_free()

func _physics_process(delta: float) -> void:
	global_position += speed * delta * -global_transform.basis.z
	
func _on_collision(body: Node3D):
	if damage_player and body is Player: 
		body.take_damage(damage)
		queue_free()
	
	if body is Enemy:
		if damage_enemies:
			body.take_damage(damage, global_position, 0.0)
			queue_free()
	
	if body is not Enemy and body is not Player:
		queue_free()
