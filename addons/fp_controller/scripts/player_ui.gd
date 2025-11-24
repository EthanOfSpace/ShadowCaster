@tool
class_name PlayerUI extends Control

@onready var crosshair: Control = %Crosshair

func _ready() -> void:
	$DeathScreen.visible = false

## Use this method if you want to draw a custom crosshair. Remove if you want to use a custom image for the crosshair
func _draw_crosshair() -> void:
	crosshair.draw_circle(Vector2.ZERO, 1.0, Color.WHITE)


func _on_crosshair_draw() -> void:
	_draw_crosshair()

func death_screen():
	$DeathScreen.visible = true
	$DeathScreen/DeathAnim.play("death_screen")
