extends Node3D

var health := 100

func take_damage(amount):
	health -= amount
	print("Enemy took", amount, "damage. Health now:", health)

	if health <= 0:
		queue_free()
