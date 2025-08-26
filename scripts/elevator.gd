extends AnimatableBody3D

@export var lever_node: NodePath  # ref to the lever so we can play its animations
@onready var lever = get_node(lever_node)
@onready var lever_anim = lever.get_node("AnimationPlayer")

var isMoving = false
var current_floor : int = 0
const MAX_FLOORS : int = 5

func move_elevator_up_floor():
	if isMoving:
		return
	isMoving = true
	
	# Play lever activate animation
	if lever_anim.has_animation("Activate"):
		lever_anim.play("Activate")
	
	var tween = get_tree().create_tween()
	var target_pos = position + Vector3(0, 15, 0)
	tween.tween_property(self, "position", target_pos, 5.0)
	tween.finished.connect(on_elevator_finished_moving)

func move_elevator_down_floor():
	current_floor -= 1
	if isMoving:
		return
	isMoving = true

	if lever_anim.has_animation("Activate"):
		lever_anim.play("Activate")
	
	var tween = get_tree().create_tween()
	var target_pos = position + Vector3(0, -15, 0)
	tween.tween_property(self, "position", target_pos, 5.0)
	tween.finished.connect(on_elevator_finished_moving)

func on_elevator_finished_moving():
	isMoving = false
	
	if lever_anim.has_animation("ReturnToIdle"):
		lever_anim.play("ReturnToIdle")
	
	print("Elevator finished moving!")
