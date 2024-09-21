extends State
class_name FallState

@export var player:Player

func physics_update(delta: float):
	player.velocity += player.get_gravity() * delta
	
	if player.is_on_floor():
		emit_signal("Transitioned", self, "idle")
	
	##Ataques
	if Input.is_action_just_pressed("ui_accept"):
		player.current_attack = player.resource.attacks[0]
		emit_signal("Transitioned", self, "ataqueAereo")
	##...
