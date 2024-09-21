extends State
class_name BloqueioState

@export var player : Player

func enter():
	player.velocity.x = 0
	player.defesa = true

func update(delta:float):
	if Input.is_action_just_released("ui_cancel"):
		emit_signal("Transitioned", self, "idle")

func exit():
	player.defesa = false

func _on_die():
	emit_signal("Transitioned", self, "morto")
