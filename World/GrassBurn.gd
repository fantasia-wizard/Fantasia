extends AnimatedSprite

func _ready():
	frame = 0

func _on_GrassBurn_animation_finished():
	queue_free()
