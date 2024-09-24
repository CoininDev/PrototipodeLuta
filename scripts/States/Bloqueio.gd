extends State
class_name BloqueioState


func enter():
	player.velocity.x = 0
	player.defesa = true
	player.animspr.play("bloqueio")

func update(delta:float):
	if Input.is_action_just_released("down"):
		emit_signal("Transitioned", self, "idle")

func exit():
	player.defesa = false
	player.animspr.play_backwards("bloqueio")

func _on_die():
	emit_signal("Transitioned", self, "morto")
