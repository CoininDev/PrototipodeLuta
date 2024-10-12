extends Node
class_name State

signal Transitioned
var active := false
@export var player: Player
@export var anim: AnimationPlayer

func enter() -> void: pass
func exit() -> void: pass
func update(_delta:float) -> void: pass
func physics_update(_delta:float) -> void: pass
func check_attacks(falling:bool) -> void:
	##Ataques
	for atk in player.resource.attacks.values():
		if Input.is_action_just_pressed(atk.trigger) and not atk.hidden:
			player.current_attack = atk
			emit_signal("Transitioned", self, "attack")
			#if falling:
				#emit_signal("Transitioned", self, "fallingAttack")
			#else:
				#emit_signal("Transitioned", self, "attack")

func anim_name(s: String) -> String:
	if player.resource:
		return player.resource.name + "/" + s
	return ""

func gravity(delta: float):
	if !player.is_on_floor():
		player.velocity += player.get_gravity() * delta
	else:
		player.velocity.y = 0
