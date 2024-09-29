extends State
class_name BlockStt


func enter():
	player.velocity.x = 0
	player.defesa = true
	anim.play(anim_name("block"))

func update(_delta:float):
	if Input.is_action_just_released("down"):
		emit_signal("Transitioned", self, "idle")

func exit():
	player.defesa = false
	anim.play_backwards(anim_name("block"))

func _on_die():
	emit_signal("Transitioned", self, "dead")
