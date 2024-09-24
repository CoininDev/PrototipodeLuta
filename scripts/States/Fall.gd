extends State
class_name FallState

func enter():
	player.animspr.play("fall")

func physics_update(delta: float):
	player.velocity += player.get_gravity() * delta
	
	if player.is_on_floor():
		emit_signal("Transitioned", self, "idle")
	
	attack(true)
