extends State
class_name JumpStt

@export var forca_de_pulo:float = -500
func enter():
	player.velocity.y = forca_de_pulo
	anim.play(anim_name("jump"))

func physics_update(delta: float):
	gravity(delta)
	
	if player.velocity.y > 0:
		emit_signal("Transitioned", self, "fall")
	if Input.is_action_just_pressed("up"):
		emit_signal("Transitioned", self, "flyingIdle")

	check_attacks(true)

func _on_hit():
	emit_signal("Transitioned", self, "hitstun")
