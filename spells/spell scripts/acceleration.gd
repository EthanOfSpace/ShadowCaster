extends ProjectilePattern
class_name Acceleration

@export var initial_speed : float = 50.0
@export var final_speed : float = 500.0
@export var duration : float 

func move(projectile : Projectile, delta):
	var time_passed
	if(time_passed <= duration):
		time_passed <= delta
		var speed = projectile.velocity.length()
