extends State
class_name DeadStt

func enter():
	anim.play(anim_name("death"))
	anim.animation_finished.connect(die)


func die(_anim):
	player.queue_free()
