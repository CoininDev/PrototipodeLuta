extends State
class_name MortoState

@export var player:Player

func enter():
	player.queue_free()
