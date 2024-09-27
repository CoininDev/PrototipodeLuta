extends AttackStt
class_name FallingAttackStt

func enter():
	anim.play(anim_name(player.current_attack))
	anim.animation_finished.connect(_on_finish)
	hitbox.Attack.connect(_on_attack)

func physics_update(delta: float):
	if !player.is_on_floor():
		player.velocity += player.get_gravity() * delta

func _on_finish(_a):
	emit_signal("Transitioned", self, "fall")
