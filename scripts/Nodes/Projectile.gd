extends Area2D
class_name Projectile

@export var direction: Vector2
@export var vel: float = 1
@export var dano: float = 20
@export var agent: Player
func _ready() -> void:
	scale *= direction.x
	
func _process(delta: float) -> void:
	position += direction * vel * delta

	var bodies = get_overlapping_bodies()
	for body in bodies:
		print(body)
		if body is Player and body != agent: 
			body.damage(dano, agent.current_attack.hit_push_force)
			queue_free()


func _on_timer_timeout() -> void:
	queue_free()
