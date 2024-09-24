extends State
class_name AtaqueState

@export var anim: AnimationPlayer
@export var hitbox: Area2D
@export var hitbox_col: CollisionShape2D


func enter():
	player.velocity.x = 0
	anim.play(player.current_attack.animation)
	anim.animation_finished.connect(_on_anim_end)
	player.animspr.play(player.current_attack.sprites_name)

func _on_anim_end(_anim_name: StringName):
	emit_signal("Transitioned", self, "idle")

func exit():
	var bodies = hitbox.get_overlapping_bodies()
	for body in bodies:
		if body is Player:
			body.damage(player.current_attack.damage)
	anim.animation_finished.disconnect(_on_anim_end)

func _on_hit():
	emit_signal("Transitioned", self, "hitstun")

func _on_die():
	emit_signal("Transitioned", self, "morto")
