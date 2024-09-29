extends State
class_name AttackStt
@export var hitbox: Hitbox
@export var hitbox_col: CollisionShape2D


func enter():
	player.velocity.x = 0
	anim.play(anim_name(player.current_attack.animation))
	anim.animation_finished.connect(_on_finish)
	hitbox.Attack.connect(_on_attack)

func _on_attack(dano:float):
	var bodies = hitbox.get_overlapping_bodies()
	for body in bodies:
		if body is Player and body != player: #que frase estúpida pqp
			body.damage(dano)

func _on_finish(_a):
	anim.play("RESET")
	emit_signal("Transitioned", self, "idle")

func exit():
	hitbox.Attack.disconnect(_on_attack)
	anim.animation_finished.disconnect(_on_finish)

func _on_hit():
	emit_signal("Transitioned", self, "hitstun")

func _on_die():
	emit_signal("Transitioned", self, "dead")
