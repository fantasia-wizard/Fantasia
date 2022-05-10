extends "res://NPC/Npc.gd"

func text_show():
	if not 6 in PlayerStats.quests_completed:
		if PlayerStats.quest_id == 6 and PlayerStats.has_quest:
			text='Go slay 20 bats.  You can find them just south of here, past the mountains.'
		else:
			text = 'I have a quest for you!  Can you go slay 20 bats?  You can find them just south of here, past the mountains.'
			PlayerStats.quest(6, 'Bat Hunter II', 'Slay 20 bats.')

	else:
		if not 7 in PlayerStats.quests_completed:
			if PlayerStats.quest_id == 7 and PlayerStats.has_quest:
				text='Go slay 30 bats.  You can find them just south of here, past the mountains.'
			else:
				text = 'I have a quest for you!  Can you go slay 30 bats?  You can find them just south of here, past the mountains.'
				PlayerStats.quest(7, 'Bat Hunter III', 'Slay 30 bats.')

		else:
			text = 'Good job slaying bats.'
			has_quest = false


func _process(delta: float) -> void:
	if 6 in PlayerStats.quests_completed and 7 in PlayerStats.quests_completed:
		text = 'Thanks for harvesting my wheat for me!'
		has_quest = false
