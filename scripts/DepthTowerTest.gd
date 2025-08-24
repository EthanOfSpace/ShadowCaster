extends Node3D

@onready var player = Manager.player

#moved all this to an autoload (manager.gd) so theres a global reference to the player at all times
#plus hard coding a path to the player might cause errors if the player is deleted or moved to a different scene

#func _ready():
	#print("Player node:", player)
#
#func _physics_process(_delta):
	#get_tree().call_group("enemies","update_target_location", player.global_transform.origin) #getting player position for enemy pathing purposes
