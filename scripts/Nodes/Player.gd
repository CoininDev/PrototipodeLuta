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
var current_attack: Attack
#move
var dir_x: int
var dir_y: int
var dir_x_switch: int

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
	dir_x_switch = 1
	$hitbox/CollisionShape2D.disabled = true
	$hitbox/CollisionShape2D.shape = RectangleShape2D.new()
	if resource:
		vida = resource.health
		$AnimationPlayer.add_animation_library(resource.name,resource.animations)
		#$AnimatedSprite2D.sprite_frames = resource.sprites
	
	for state in $StateMachine.get_children():
		if state.has_method("_on_hit"):
			Hit.connect(state._on_hit)
		if state.has_method("_on_die"):
			Die.connect(state._on_die)
	
	
func die():
	emit_signal("Die")

func _physics_process(_delta: float) -> void:
	if !dummy:
		dir_x = Input.get_axis("l", "r")
		dir_y = Input.get_axis("up", "down")
		if dir_x != 0 and dir_x_switch != dir_x:
			$hitbox.scale.x *= -1
			$Sprite2D.flip_h = !$Sprite2D.flip_h
			dir_x_switch = dir_x
		move_and_slide()
