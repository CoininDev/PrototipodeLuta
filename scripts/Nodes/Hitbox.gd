extends Area2D
class_name Hitbox

signal Attack

func attack(dano: float):
	emit_signal("Attack", dano)
