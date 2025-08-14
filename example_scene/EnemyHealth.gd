extends CharacterBody3D

var health := 100
@export var SPEED = 2
@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D

func take_damage(amount):
	health -= amount
	print("Enemy took", amount, "damage. Health now:", health)

	if health <= 0:
		queue_free() #death for now lol (just destroys it)

func update_target_location(target_location):
	print("Target location received by enemy:", target_location)
	await get_tree().process_frame  # Wait one frame for NavigationServer sync
	nav_agent.set_target_position(target_location)

func _physics_process(_delta):
	if nav_agent.is_navigation_finished():
		return
	
	var currentLocation = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - currentLocation).normalized() * SPEED
	
	velocity = new_velocity
	move_and_slide()
