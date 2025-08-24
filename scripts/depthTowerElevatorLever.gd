extends StaticBody3D

#var health 

@export var elevator_node: NodePath   # assign the  node in the editor
@onready var elevator = get_node(elevator_node)  # reference to the elevator script

func _ready():
	add_to_group("Damageable")

func take_damage(amount): #you hit the lever
	print("YOU HIT THE LEVER")
	if(elevator.isMoving == false):
		elevator.move_elevator_down_floor()  #this function will deal with falsing the isMoving bool

	
