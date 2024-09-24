extends AtaqueState
class_name AtaqueAereoState

func enter():
	anim.play(player.current_attack.animation)
	anim.animation_finished.connect(_on_anim_end)
	player.animspr.play(player.current_attack.sprites_name)

func _on_anim_end(_anim_name: StringName):
	emit_signal("Transitioned", self, "fall")

func physics_update(delta: float):
	if !player.is_on_floor():
		player.velocity += player.get_gravity() * delta
