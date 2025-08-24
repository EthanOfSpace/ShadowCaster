extends Node

var player : Player

func _physics_process(delta: float) -> void:
	if player: #checking if player exists before using its position
		update_enemy_targets(player.global_position)

func update_enemy_targets(target_pos : Vector3):
	get_tree().call_group("enemies","update_target_location", target_pos)
