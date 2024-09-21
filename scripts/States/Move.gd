extends State
class_name MoveState

@export var player: Player
@export var speed: float = 19000
@export var hitbox: Area2D

func update(delta:float):
	if player.dummy:
		emit_signal("Transitioned", self, "idle")
	
	if player.direction == 0:
		emit_signal("Transitioned", self, "idle")
	
	player.velocity.x = player.direction * speed * delta
	
	##Transitions
	if Input.is_action_pressed("ui_up"):
		emit_signal("Transitioned", self, "pulo")
	if !player.is_on_floor():
		emit_signal("Transitioned", self, "fall")
	if Input.is_action_pressed("ui_cancel"):
		emit_signal("Transitioned", self, "bloqueio")
	
	##Ataques
	if Input.is_action_just_pressed("ui_accept"):
		player.current_attack = player.resource.attacks[0]
		emit_signal("Transitioned", self, "ataque")
	##...

func _on_hit():
	emit_signal("Transitioned", self, "hitstun")

func _on_die():
	emit_signal("Transitioned", self, "morto")
