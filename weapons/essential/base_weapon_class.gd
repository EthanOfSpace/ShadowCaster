class_name Weapon
extends Node3D

@export var animation_player : AnimationPlayer
@export_group("Animations")
@export var attack_animation_name := "Primary"
@export var idle_animation_name := "Idle"
@export var cooldown_animation_name := "Cooldown"

var can_use := true

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("shortAttack") and can_use:
		primary()
		animation_player.play(attack_animation_name)
		animation_player.queue(cooldown_animation_name)
		can_use = false

func cooldown_over():
	can_use = true

func primary():
	pass
