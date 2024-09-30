extends State
class_name AttackStt
@export var hitbox: Hitbox
@export var hitbox_col: CollisionShape2D

var linkable:bool = false

func enter():
	player.velocity.x = 0
	anim.play(anim_name(player.current_attack.animation))
	anim.animation_finished.connect(_on_finish)

func attack(dano:float):
	var bodies = hitbox.get_overlapping_bodies()
	for body in bodies:
		if body is Player and body != player: #que frase estúpida pqp
			body.damage(dano)

func toggle_link(val: bool):
	linkable = val

func physics_update(delta: float):
	if !player.is_on_floor():
		player.velocity += player.get_gravity() * delta
	else:
		player.velocity.x = 0
	
	if linkable:
		for atk_name in player.current_attack.sequence:
			var atk = player.resource.attacks[atk_name]
			if Input.is_action_just_pressed(atk.trigger):
				player.current_attack = atk
				if player.is_on_floor():
					emit_signal("Transitioned", self, "attack")
				else:
					emit_signal("Transitioned", self, "fallingAttack")

func _on_finish(_a):
	anim.play("RESET")
	emit_signal("Transitioned", self, "idle")

func exit():
	linkable = false
	anim.animation_finished.disconnect(_on_finish)

func _on_hit():
	emit_signal("Transitioned", self, "hitstun")

func _on_die():
	emit_signal("Transitioned", self, "dead")
