extends Control

func _ready():
	PlayerStats.load_game()
	$Control/Control/CheckButton.set('pressed', PlayerStats.touch_controls)

func _on_Play_pressed():
	HUD.loading = true
# warning-ignore:return_value_discarded
	PlayerStats.call_deferred('load_game')
	get_tree().change_scene('res://World/World.tscn')

func _on_Reset_pressed():
	$'Reset Confirmation'.popup_centered()

func _on_Exit_pressed():
	get_tree().quit()


func _on_Reset_Confirmation_confirmed():
	PlayerStats.reset()
	PlayerStats.save_game()

func _on_Settings_pressed():
	pass

func _on_CheckButton_toggled(button_pressed):
	PlayerStats.touch_controls = button_pressed
	PlayerStats.save_game()


func _on_Tutorial_pressed() -> void:
	PlayerStats.call_deferred('load_game')
# warning-ignore:return_value_discarded
	get_tree().change_scene('res://World/Tutorial.tscn')
