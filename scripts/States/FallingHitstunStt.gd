extends HitstunStt
class_name FallingHitstunStt

func physics_update(delta:float):
	if !player.is_on_floor():
		player.velocity += player.get_gravity() * delta
	else:
		emit_signal("Transitioned", self, "hitstun")

func _on_timeout():
	emit_signal("Transitioned", self, "fall")
