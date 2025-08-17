extends Node3D

@onready var player = $Player

func _ready():
	print("Player node:", player)

func _physics_process(_delta):
	get_tree().call_group("enemies","update_target_location", player.global_transform.origin) #getting player position for enemy pathing purposes
