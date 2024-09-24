extends State
class_name IdleState


func enter():
	player.velocity.x = 0
	player.velocity.y = 0
	player.animspr.play("idle")

func update(_delta:float):
	##Transitions
	if player.dir_x != 0 and !player.dummy:
		emit_signal("Transitioned", self, "move")
	if !player.is_on_floor():
		emit_signal("Transitioned", self, "fall")
	if Input.is_action_just_pressed("up") and !player.dummy:
		emit_signal("Transitioned", self, "pulo")
	if Input.is_action_just_pressed("down"):
		emit_signal("Transitioned", self, "bloqueio")
	
	attack(false)

func _on_hit():
	emit_signal("Transitioned", self, "hitstun")

func _on_die():
	emit_signal("Transitioned", self, "morto")
