extends Sprite

var time = 0.0;

onready var timer = $Timer

func _ready():
	rotation_degrees = rand_range(-365.0, 365.0)
	time = rand_range(6.0, 12.0)
	timer.start(time)

func _process(_delta):
	material.set_shader_param('alpha', timer.time_left / time)

func _on_Timer_timeout():
	queue_free()


func _on_Area2D_body_entered(_body):
	queue_free()
