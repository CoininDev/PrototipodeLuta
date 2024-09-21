extends CharacterBody2D
class_name Player

signal Hit
signal Die

@export_category("character")
@export var resource: CharResource
@export var dummy: bool

@export_category("combat")
@export var vida: float = 100.0
@export var defesa: bool
var current_attack: Attack = null

#move
var direction: int
var dir_switch: int

func damage(dano:float) -> void:
	emit_signal("Hit")
	if defesa:
		vida -= dano * 0.75
		return
	vida -= dano
	if vida <= 0:
		die()
	print(vida)

func _ready() -> void:
	dir_switch = 1
	if resource:
		vida = resource.health
		$AnimationPlayer.add_animation_library("Teste",resource.animations)
	
	for state in $StateMachine.get_children():
		if state.has_method("_on_hit"):
			Hit.connect(state._on_hit)
		if state.has_method("_on_die"):
			Die.connect(state._on_die)
func die():
	emit_signal("Die")

func _physics_process(_delta: float) -> void:
	direction = Input.get_axis("ui_left", "ui_right")
	if direction and dir_switch != direction:
		$hitbox.scale.x *= -1
		dir_switch = direction
	move_and_slide()
