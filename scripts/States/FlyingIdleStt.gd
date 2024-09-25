extends State
class_name FlyingIdleStt

func enter():
	player.velocity.x = 0
	player.velocity.y = 0

func update(delta: float):
	if player.dir_x or player.dir_y:
		emit_signal("Transitioned", self, "flyingMove")
	if player.is_on_floor():
		emit_signal("Transitioned", self, "idle")
	attack(false)
