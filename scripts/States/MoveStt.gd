extends State
class_name MoveStt

@export var speed: float = 19000
@export var hitbox: Area2D

func enter():
	anim.play(anim_name("move"))

func update(delta:float):
	if player.dir_x == 0:
		emit_signal("Transitioned", self, "idle")
	
	player.velocity.x = player.dir_x * speed * delta
	
	##Transitions
	if Input.is_action_pressed("up"):
		emit_signal("Transitioned", self, "jump")
	if !player.is_on_floor():
		emit_signal("Transitioned", self, "fall")
	if Input.is_action_pressed("down"):
		emit_signal("Transitioned", self, "block")
	
	check_attacks(false)

func _on_hit():
	emit_signal("Transitioned", self, "hitstun")

func _on_die():
	emit_signal("Transitioned", self, "dead")
