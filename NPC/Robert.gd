extends "res://NPC/Npc.gd"

func text_show():
	if not 1 in PlayerStats.quests_completed:
		text = 'Go talk to my brother Bobert first.'
	else:
		if not 3 in PlayerStats.quests_completed:
			if PlayerStats.quest_id == 3 and PlayerStats.has_quest:
				text = 'Go slay 30 rats!'
			else:
				text = 'I have a quest for you!  Can you go slay 30 rats?'
				PlayerStats.quest(3, 'Rat Slayer III', 'Slay 30 rats')
		else:
			text = 'Great job slaying rats!'
			has_quest = false

func _process(delta: float) -> void:
	if 3 in PlayerStats.quests_completed:
		text = 'Thanks for killing rats for me!'
		has_quest = false
