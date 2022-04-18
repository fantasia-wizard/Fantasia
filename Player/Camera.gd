extends Camera2D

var last_mouse_pos = Vector2.ZERO
var empty = load('res://empty.png')

func _ready():
	OS.window_borderless = false

func _process(_delta):
	if Input.is_action_just_pressed('fullscreen'):
		OS.window_fullscreen = not OS.window_fullscreen
	smoothing_speed = 5 + abs(PlayerStats.velocity.x + PlayerStats.velocity.y)/50.0


