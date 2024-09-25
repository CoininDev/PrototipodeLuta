extends Node
class_name State

signal Transitioned
var active := false
@export var player: Player

func enter() -> void: pass
func exit() -> void: pass
func update(_delta:float) -> void: pass
func physics_update(_delta:float) -> void: pass
func attack(aereo:bool) -> void:
	var attacked: bool
	##Ataques
	if Input.is_action_just_pressed("atk1") and !player.dummy:
		player.current_attack = player.resource.attacks[0]
		attacked = true
	if Input.is_action_just_pressed("atk2") and !player.dummy:
		player.current_attack = player.resource.attacks[1]
		attacked = true
	if Input.is_action_just_pressed("atk3") and !player.dummy:
		player.current_attack = player.resource.attacks[2]
		attacked = true
	
	if attacked:
		if aereo:
			emit_signal("Transitioned", self, "fallingAttack")
		else:
			emit_signal("Transitioned", self, "attack")
	
	##...
