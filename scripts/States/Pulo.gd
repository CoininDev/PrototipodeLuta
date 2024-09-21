extends State
class_name PuloState

@export var forca_de_pulo:float = -500
@export var player:Player

func enter():
	player.velocity.y = forca_de_pulo

func physics_update(delta: float):
	player.velocity += player.get_gravity() * delta
	
	if player.velocity.y > 0:
		emit_signal("Transitioned", self, "fall")

	##Ataques
	if Input.is_action_just_pressed("ui_accept"):
		player.current_attack = player.resource.attacks[0]
		emit_signal("Transitioned", self, "ataqueAereo")
	##...
