extends AttackStt
class_name FallingAttackStt

func enter():
	anim.play(player.current_attack.animation)
	player.animspr.play(player.current_attack.sprites_name)
	anim.animation_finished.connect(_on_anim_end)
	player.animspr.animation_finished.connect(_on_animspr_end)

func physics_update(delta: float):
	if !player.is_on_floor():
		player.velocity += player.get_gravity() * delta

func _on_animspr_end():
	emit_signal("Transitioned", self, "fall")
