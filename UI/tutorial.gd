extends Label

func _process(delta):
	if visible and Input.is_action_just_pressed('ui_accept'):
		queue_free()
