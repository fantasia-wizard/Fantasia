extends "res://NPC/Npc.gd"


func _on_Richard5_text_show() -> void:
	PlayerStats.skill_points += 1
	PlayerStats.achievement('You recieved 1 skill point.', 'Spend it in the menu.', 'You got a skill point!')
