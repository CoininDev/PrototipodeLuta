extends State
class_name HitstunState

var timer: Timer

func enter():
	player.velocity.x = 0
	timer = Timer.new()
	timer.one_shot = true
	timer.timeout.connect(_on_time_out)
	add_child(timer)
	timer.start(0.5)

func _on_time_out():
	emit_signal("Transitioned", self, "idle")

func _on_die():
	emit_signal("Transitioned", self, "morto")

func exit():
	timer.timeout.disconnect(_on_time_out)
	get_child(0).queue_free()
