extends State
class_name AttackStt

@export var anim: AnimationPlayer
@export var hitbox: Area2D
@export var hitbox_col: CollisionShape2D


func enter():
	player.velocity.x = 0
	player.animspr.play(player.current_attack.sprites_name)
	player.animspr.animation_finished.connect(_on_animspr_end)
	anim.play(player.current_attack.animation)
	anim.animation_finished.connect(_on_anim_end)

func _on_animspr_end():
	emit_signal("Transitioned", self, "idle")

func _on_anim_end(_anim_name: StringName):
	var bodies = hitbox.get_overlapping_bodies()
	for body in bodies:
		if body is Player:
			body.damage(player.current_attack.damage)

func exit():
	anim.animation_finished.disconnect(_on_anim_end)
	player.animspr.animation_finished.disconnect(_on_animspr_end)

func _on_hit():
	emit_signal("Transitioned", self, "hitstun")

func _on_die():
	emit_signal("Transitioned", self, "dead")
