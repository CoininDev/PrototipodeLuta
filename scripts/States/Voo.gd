extends State
class_name VooState

func enter():
	player.velocity.x = 0
	player.velocity.y = 0

func update(delta: float):
	if player.dir_x or player.dir_y:
		emit_signal("Transitioned", self, "moveVoo")
	if player.is_on_floor():
		emit_signal("Transitioned", self, "idle")
	attack(false)
