class_name Weapon
extends Node3D

@export var animation_player : AnimationPlayer
@export_group("Animations")
@export var short_attack_animation := "Primary"
@export var heavy_charge_animation := "Heavy_Charge"
@export var heavy_attack_animation := "Heavy_Attack"
@export var idle_animation := "Idle"
@export var cooldown_animation := "Cooldown"
@export var heavy_cooldown_animation := "Heavy_Cooldown"

var can_use := true
var heavy_charged := false

const CHARGE_BUFFER = 0.3
var charge_check = 0.0

func _input(event: InputEvent) -> void:
	pass
	#if Input.is_action_pressed("shortAttack") and can_use:
		#if !animation_player.is_playing():
			#animation_player.play(heavy_charge_animation_name)
	#if Input.is_action_just_released("shortAttack") and heavy_charged:
		#heavy()
		#animation_player.play(heavy_attack_animation_name)
		#animation_player.queue(heavy_cooldown_animation_name)
		#can_use = false
		#heavy_charged = false
	#
	#if Input.is_action_just_pressed("shortAttack") and can_use:
		#primary()
		#animation_player.play(short_attack_animation_name)
		#animation_player.queue(cooldown_animation_name)
		#can_use = false

func _process(delta: float) -> void:
	if Input.is_action_pressed("shortAttack") and can_use:
		charge_check += delta
		if charge_check>CHARGE_BUFFER and !animation_player.is_playing() and !heavy_charged: 
				animation_player.play(heavy_charge_animation)
	
	if Input.is_action_just_released("shortAttack"):
		if charge_check <= CHARGE_BUFFER:
			primary()
		elif heavy_charged:
			heavy()
		else:
			animation_player.play(idle_animation)
		
		charge_check=0.0

func cooldown_over():
	can_use = true
	heavy_charged = false
	
func primary():
	animation_player.play(short_attack_animation)
	animation_player.queue(cooldown_animation)
	can_use = false
func heavy():
	animation_player.play(heavy_attack_animation)
	animation_player.queue(heavy_cooldown_animation)
	can_use = false
	heavy_charged = false

func charge_heavy():
	heavy_charged = true
