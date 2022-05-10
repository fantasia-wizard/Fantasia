extends ConfirmationDialog

func _process(_delta):
	if Input.is_action_just_pressed('inventory'):
		visible = false
