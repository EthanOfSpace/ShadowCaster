extends Node3D
class_name SpellManager
 
@export var spells: Array[SpellStrategy]

@export var maxMana: int = 100
var currentMana

@export var projectileSpawnPoint: Node3D

func _ready():
	currentMana = maxMana

func try_to_cast(spell: SpellStrategy):
	if(currentMana - spell.cost > 0):
		spell.cast(projectileSpawnPoint)
		currentMana -= spell.cost
		var h_tween = create_tween()
		h_tween.set_ease(Tween.EASE_OUT)
		h_tween.set_trans(Tween.TRANS_CUBIC)
		h_tween.tween_property(%ManaBarCrop, "scale:x", currentMana/maxMana, 0.2)
	
	

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_Q:
		try_to_cast(spells[0])
