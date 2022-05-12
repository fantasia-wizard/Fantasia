extends "res://NPC/Npc.gd"

func text_show():
	pass

func _process(delta: float) -> void:
	if PlayerStats.quest_id == 8 and  PlayerStats.has_quest:
		text = 'I wonder what\'s in the cave...'
	else:
		text = 'Is it safe in there now?  Are you sure there aren\'t more monsters?'
	has_quest = false
