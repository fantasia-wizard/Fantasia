extends "res://NPC/Npc.gd"

func text_show():
	pass

func _process(delta: float) -> void:
	if PlayerStats.quest_id == 8 and  PlayerStats.has_quest:
		text = 'There are probably very valuable crystals in this cave, if we could mine them out, we could make a fortune.'
	else:
		text = 'We should get a team of miners to mine those crystals out, we could be rich!'
	has_quest = false
