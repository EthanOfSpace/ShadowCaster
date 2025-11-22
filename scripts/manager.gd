extends Node

var player : Player

# I need this because sometimes my gpu crashes when I close a preview window normally
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("safe_quit"):
		get_tree().current_scene.queue_free()
		get_tree().quit()

#func _physics_process(delta: float) -> void:
	#if player: #checking if player exists before using its position
		#update_enemy_targets(player.global_position)
#
#func update_enemy_targets(target_pos : Vector3):
	#get_tree().call_group("enemies","update_target_location", target_pos)
