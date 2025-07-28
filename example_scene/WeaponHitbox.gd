extends Area3D


var meleeDamage = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	print("HELLO?")
	connect("body_entered", self._on_hitbox_body_entered)

func _on_hitbox_body_entered(body):
	if body.is_in_group("Damageable"):
		body.take_damage(meleeDamage)
		print("You did damage")
	else: 
		print("Not a damageable object")
