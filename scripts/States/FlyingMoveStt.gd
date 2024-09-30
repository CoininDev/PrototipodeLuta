extends State
class_name FlyingMoveStt

@export var speed: float = 19000

func update(delta:float):
	var dir = Vector2(player.dir_x, player.dir_y).normalized()
	player.velocity = dir * speed * delta

	if player.is_on_floor():
		emit_signal("Transitioned", self, "idle")
	if !player.dir_x and !player.dir_y:
		emit_signal("Transitioned", self, "flyingIdle")
	check_attacks(false)
