extends State
class_name JumpStt

@export var forca_de_pulo:float = -500
func enter():
	player.velocity.y = forca_de_pulo
	player.animspr.play("pulo")

func physics_update(delta: float):
	player.velocity += player.get_gravity() * delta
	
	if player.velocity.y > 0:
		emit_signal("Transitioned", self, "fall")
	if Input.is_action_just_pressed("up"):
		emit_signal("Transitioned", self, "flyingIdle")

	attack(true)
