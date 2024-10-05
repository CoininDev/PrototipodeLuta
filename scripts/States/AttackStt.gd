extends State
class_name AttackStt
@export var hitbox: Area2D
@export var hitbox_col: CollisionShape2D

var linkable:bool = false
var cancelable:bool = false

func enter():
	player.velocity.x = 0
	anim.stop(true)
	anim.play(anim_name(player.current_attack.animation))
	anim.animation_finished.connect(_on_finish)
	linkable = false
	cancelable = false

func attack(dano:float):
	var bodies = hitbox.get_overlapping_bodies()
	for body in bodies:
		if body is Player and body != player: #que frase estúpida pqp
			body.damage(dano)

func toggle_link(val: bool):
	linkable = val

func toggle_cancel(val:bool):
	cancelable = val

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
	
	if cancelable:
		if Input.is_action_just_pressed("down"):
			emit_signal("Transitioned", self, "block")
	
func _on_finish(_a):
	anim.play("RESET")
	emit_signal("Transitioned", self, "idle")

func exit():
	anim.animation_finished.disconnect(_on_finish)

func _on_hit():
	emit_signal("Transitioned", self, "hitstun")

func _on_die():
	emit_signal("Transitioned", self, "dead")
