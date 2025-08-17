extends Camera3D

@export var speed := 44.0

@export var hand : Node3D
@export var weapon_sway_amount : float = 0.1
@export var weapon_rotation_amount : float = 0.1
@export var invert_weapon_sway : bool = false

var hand_start_pos : Vector3
var mouse_input : Vector2

func _input(event):
	if event is InputEventMouseMotion:
		mouse_input = event.relative

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	hand_start_pos = hand.position

func _physics_process(delta: float) -> void:
	var weight: float = clamp(speed * delta, 0.0, 1.0)
	global_transform = global_transform.interpolate_with(
		get_parent().global_transform, weight
	)
	global_position = get_parent().global_position
	
	weapon_sway(delta)

func weapon_sway(delta):
	mouse_input = lerp(mouse_input,Vector2.ZERO,10*delta)
	hand.rotation.x = lerp(hand.rotation.x, mouse_input.y * weapon_rotation_amount * (-1 if invert_weapon_sway else 1), 10 * delta)
	hand.rotation.y = lerp(hand.rotation.y, mouse_input.x * weapon_rotation_amount * (-1 if invert_weapon_sway else 1), 10 * delta)	
