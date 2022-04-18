extends AnimatedSprite

func _ready():
	frame = 0
	playing = true
	call_deferred('displace')

func _on_WheatBreak_animation_finished():
	playing = false
	frame = 9

func displace():
	global_position += Vector2(rand_range(-5, 5), rand_range(-5, 5))
