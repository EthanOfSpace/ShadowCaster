extends CharacterBody3D

@export var SPEED = 2

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D

func update_target_location(target_location):
	nav_agent.set_target_location(target_location)

func _physics_process(_delta):
	var currentLocation = global_transform.origin
	var next_location = nav_agent.get_next_location()
	var new_velocity = (next_location - currentLocation).normalized() * SPEED
	
	velocity = new_velocity
	move_and_slide()

	
	
