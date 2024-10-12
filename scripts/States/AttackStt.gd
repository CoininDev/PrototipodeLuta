extends State
class_name AttackStt
@export var hitbox: Area2D
@export var hitbox_col: CollisionShape2D
@export var projectile: PackedScene
@export var projectile_marker: Marker2D

var linkable:bool = false
var cancelable:bool = false
var launch_pos: Vector2 = Vector2.ZERO

func enter():
	#player.velocity.x = 0
	anim.stop(true)
	anim.play(anim_name(player.current_attack.animation))
	anim.animation_finished.connect(_on_finish)
	linkable = false
	cancelable = false
	projectile = player.current_attack.projectile

func toggle_link(val: bool):
	linkable = val

func toggle_cancel(val:bool):
	cancelable = val

func launch(dano:float):
	var launch : Projectile = projectile.instantiate()
	launch.agent = player
	launch.dano = dano
	launch.direction = Vector2(player.dir_x_switch, 0)
	
	player.world.add_child(launch)
	launch.global_position = projectile_marker.global_position

func set_launch_pos(pos: Vector2):
	launch_pos = pos

func move(move_id: int):
	player.velocity += player.current_attack.move_forces[move_id] * Vector2(player.dir_x_switch, 0)

func attack(dano:float):
	var bodies = hitbox.get_overlapping_bodies()
	for body in bodies:
		if body is Player and body != player: 
			body.damage(dano, player.current_attack.hit_push_force)

func physics_update(delta: float):
	if !player.is_on_floor():
		player.velocity += player.get_gravity() * delta
	else:
		player.velocity.x = 0
	
	if linkable:
		for atk_name in player.current_attack.sequence:
			var atk = player.resource.attacks[atk_name]
			if Input.is_action_just_pressed(atk.trigger):
				player.current_attack = atk
				emit_signal("Transitioned", self, "attack")

	
	if cancelable:
		if Input.is_action_just_pressed("down"):
			emit_signal("Transitioned", self, "block")
	
func _on_finish(_a):
	anim.play("RESET")
	if player.is_on_floor():
		emit_signal("Transitioned", self, "idle")
	else:
		emit_signal("Transitioned", self, "fall")
	
func exit():
	anim.animation_finished.disconnect(_on_finish)

func _on_hit():
	emit_signal("Transitioned", self, "hitstun")

func _on_die():
	emit_signal("Transitioned", self, "dead")
