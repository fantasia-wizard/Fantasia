extends "res://NPC/Npc.gd"

func text_show():
	if PlayerStats.level >= 5:
		if not 4 in PlayerStats.quests_completed:
			if PlayerStats.quest_id == 4 and PlayerStats.has_quest:
				text='Go slay 10 bats.  You can find them north of the forest area that you have already explored.'
			else:
				text = 'I have a quest for you!  Can you go slay 10 bats?  You can find them north of the forest area you have already explored.'
				PlayerStats.quest(4, 'Bat Hunter', 'Slay 10 bats.')

		else:
			text = 'Good job slaying bats.'
			has_quest = false
	else:
		text = 'Come back and talk to me when you are at least level 5.'

func _process(delta: float) -> void:
	if 4 in PlayerStats.quests_completed:
		text = 'Thanks for harvesting my wheat for me!'
		has_quest = false
