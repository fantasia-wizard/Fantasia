extends Button

func _ready() -> void:
# warning-ignore:return_value_discarded
	connect('pressed', self, '_on_press')

func _on_press():
	Input.action_press('ui_accept')
