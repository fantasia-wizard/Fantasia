extends AnimatedSprite


func _ready():
	frame = 0
	speed_scale = 3
	rotation_degrees = rand_range(-365, 365)

func _on_explosion_animation_finished():
	queue_free()
