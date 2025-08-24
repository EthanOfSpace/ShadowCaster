extends Area3D

@export var scene_to_load: PackedScene

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	print("YOU HIT THE LOAD TRIGGER")
	if body.name == "Player": # prolly not good to have it dependent on name but it's fine for now -Ethan
		get_tree().change_scene_to_packed(scene_to_load)
