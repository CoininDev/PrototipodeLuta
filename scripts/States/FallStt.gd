extends State
class_name FallStt

func enter():
	anim.play(anim_name("fall"))

func physics_update(delta: float):
	player.velocity += player.get_gravity() * delta
	
	if player.is_on_floor():
		emit_signal("Transitioned", self, "idle")
	
	check_attacks(true)

func _on_hit():
	emit_signal("Transitioned", self, "hitstun")
