extends Camera2D

var last_mouse_pos = Vector2.ZERO

func _ready():
	OS.window_borderless = false
	current = true
	offset = Vector2.ZERO
	smoothing_enabled = false

func _process(_delta):
	if Input.is_action_just_pressed('fullscreen'):
		OS.window_fullscreen = not OS.window_fullscreen
	smoothing_speed = 5 + abs(PlayerStats.velocity.x + PlayerStats.velocity.y)/50.0
	smoothing_enabled = true
	if PlayerStats.camera_shaking:
		match PlayerStats.shake_type:
			0:
				$AnimationPlayer.play('shake')
			1:
				$AnimationPlayer.play('earthquake')

func shake_stop():
	$AnimationPlayer.play('RESET')
	PlayerStats.camera_shaking = false

