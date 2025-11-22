extends Marker3D

@export var projectile : PackedScene
@export var target_player := true
@export var player_prediction := 1.0

func spawn_projectile():
	var p_inst = projectile.instantiate()
	var offset = Manager.player.input_direction.x * player_prediction/5.0
	
	get_tree().current_scene.add_child(p_inst)
	p_inst.global_rotation = global_rotation
	p_inst.rotate_y(offset)
	p_inst.global_position = global_position
