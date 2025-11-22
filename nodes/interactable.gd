class_name Interactable
extends Area3D

signal interacted
signal damage_interaction
signal button_interaction

signal player_detected
signal player_left

@export_category("Interaction Types")
@export var damage_activated := false
@export var button_activated := true

@export_category("Popup")
@export var interaction_popup : Label
@export var interaction_text := "[E]"

@export_category("Interaction Behavior")
@export var enabled := true
@export var hide_on_interaction := true
@export var delete_on_interaction := false

var in_range = false

func interact(button_press : bool):
	interacted.emit()
	if button_press: button_interaction.emit()
	else: damage_interaction.emit()
	
	if hide_on_interaction:
		in_range = false
		if interaction_popup: 
			interaction_popup.visible = false
	if delete_on_interaction: queue_free()

func _ready() -> void:
	if interaction_popup:
		interaction_popup.text = interaction_text
		interaction_popup.visible = false
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

func _on_body_entered(body):
	if body is Player:
		if enabled:
			player_detected.emit()
			in_range = true
			if interaction_popup and button_activated: 
				interaction_popup.visible = true

func _on_body_exited(body):
	if body is Player:
		if enabled:
			player_left.emit()
			in_range = false
			if interaction_popup and button_activated: 
				interaction_popup.visible = false

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") and enabled and in_range:
		interact(true)
