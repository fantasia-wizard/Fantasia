extends "res://NPC/Npc.gd"

func text_show():
	if 1 in PlayerStats.quests_completed and 4 in PlayerStats.quests_completed and 6 in PlayerStats.quests_completed and 7 in PlayerStats.quests_completed and not 8 in PlayerStats.quests_completed:
		if PlayerStats.quest_id == 8 and PlayerStats.has_quest:
			text='Go explore the cave in the southern mountains.'
		else:
			text = 'A few of our hunters recently found a cave in the mountains just south of here, and there seems to be something inside.  Can you go investigate?'
			PlayerStats.quest(8, 'The Ominous Cave.', 'Investigate the cave.')

	else:
		text='A lot of people need the assistance of a great wizard like you!  It could really help you on you way if you were to talk with them.'

func _process(delta: float) -> void:
	if 8 in PlayerStats.quests_completed:
		text = 'Wow, you really killed a monster that big?'
		has_quest = false
