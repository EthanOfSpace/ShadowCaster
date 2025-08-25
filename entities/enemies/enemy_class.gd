class_name Enemy
extends CharacterBody3D

@export_category("Variables")
@export var health = 10.0
@export var speed: float
@export var accel: float
@export var stop_distance = 20.0
@export var max_distance = 30.0

@export_category("Nodes")
@export var nav_agent : NavigationAgent3D
@export var seek_cast : RayCast3D
@export var mesh : Node3D
@export var animation_player : AnimationPlayer
@export var memory: Timer

@export_category("Animation Names")
@export var attack_anim = "attack"
@export var idle_anim = "idle"
@export var run_anim = "run"
@export var death_anim = "die"

var current_health = health
var moving = true
var reached = false
var dying = false
var remembering = false
var delta_accel: float
var out_of_sight = true
var can_attack = true
var distance : float
var player_pos = Vector3.ZERO

var knockback_timer := 0.0
var knockback_dir: Vector3

func _ready() -> void:
	current_health = health
	nav_agent.connect("velocity_computed", _on_navigation_agent_3d_velocity_computed)

func take_damage(amt: float, damage_pos: Vector3=Vector3.ZERO, knockback_amt: float=0.0):
	if knockback_timer <= 0.01:
		current_health -= amt
		if current_health <= 0:
			die()
			dying = true
			
		if damage_pos and knockback_amt:
			knockback_dir = (global_position.direction_to(damage_pos)).normalized()*-knockback_amt*Vector3(1,0.01,1)
			knockback_timer = 0.05

func _physics_process(delta: float) -> void:
	if knockback_timer > 0.0:
		knockback_timer-=delta
		velocity=knockback_dir
	
	if Manager.player:
		player_pos = Manager.player.global_position
		update_target_location(Manager.player.get_target_position())
		
		seek_cast.target_position = Vector3(0,0,-global_position.distance_to(player_pos))
		seek_cast.look_at(player_pos)
	
	if !is_on_floor():
		velocity.y -= 9.8*delta
	
	var direction = Vector3()
	delta_accel = accel * delta
	distance = global_position.distance_to(nav_agent.target_position)
	
	if seek_cast.is_colliding() and seek_cast.get_collider() is Player:
		remembering = true
		out_of_sight = false
	elif remembering and !out_of_sight and seek_cast.is_colliding() and !seek_cast.get_collider() is Player:
		memory.start()
		out_of_sight = true
	
	if distance > stop_distance and distance <= max_distance and !dying and remembering:
		direction = (nav_agent.get_next_path_position() - global_position)
		direction = direction.normalized() * speed
	elif distance <= max_distance:
		reached = true
	
	if !dying and animation_player.current_animation != attack_anim:
		nav_agent.set_velocity(direction)
	
	if animation_player.current_animation != attack_anim and animation_player.current_animation != death_anim:
		if (velocity * Vector3(1,0,1)).length() > 1:
			animation_player.play(run_anim)
		elif distance <= stop_distance:
			animation_player.play(attack_anim)
		else:
			animation_player.play(idle_anim)


func die():
	animation_player.play(death_anim)
	velocity.lerp(Vector3.ZERO, 15.0)

func update_target_location(target_location):
	nav_agent.target_position = target_location
	if global_position.distance_to(player_pos) < max_distance:
		mesh.look_at(player_pos)
	mesh.rotation.z = 0
	mesh.rotation.x = 0

func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	velocity = velocity.move_toward(safe_velocity, delta_accel)
	if !is_on_floor():
		velocity.y -= 2*delta_accel
	move_and_slide()
