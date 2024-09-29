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
func attack(falling:bool) -> void:
	var attacked: bool
	##Ataques

	for atk in player.resource.attacks:
		if Input.is_action_just_pressed(atk.trigger):
			player.current_attack = atk
			attacked = true
			if falling:
				emit_signal("Transitioned", self, "fallingAttack")
			else:
				emit_signal("Transitioned", self, "attack")

func anim_name(s: String) -> String:
	if player.resource:
		return player.resource.name + "/" + s
	return ""
