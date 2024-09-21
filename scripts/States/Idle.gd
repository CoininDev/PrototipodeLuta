extends State
class_name IdleState

@export var player: Player

func enter():
	player.velocity.x = 0

func update(_delta:float):
	##Transitions
	if player.direction != 0 and !player.dummy:
		emit_signal("Transitioned", self, "move")
	if !player.is_on_floor():
		emit_signal("Transitioned", self, "fall")
	if Input.is_action_just_pressed("ui_up") and !player.dummy:
		emit_signal("Transitioned", self, "pulo")
	if Input.is_action_just_pressed("ui_cancel"):
		emit_signal("Transitioned", self, "bloqueio")
	
	##Ataques
	if Input.is_action_just_pressed("ui_accept") and !player.dummy:
		player.current_attack = player.resource.attacks[0]
		emit_signal("Transitioned", self, "ataque")
	##...

func _on_hit():
	emit_signal("Transitioned", self, "hitstun")

func _on_die():
	emit_signal("Transitioned", self, "morto")
