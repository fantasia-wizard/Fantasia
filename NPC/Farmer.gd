extends "res://NPC/Npc.gd"

func text_show():
	if not 2 in PlayerStats.quests_completed:
		if PlayerStats.quest_id == 2 and PlayerStats.has_quest:
			text='Go harvest 200 wheat.  Just cut it with your sword.'
		else:
			text = 'I have a quest for you!  Can you go harvest 200 wheat from my field?  Just cut it with your sword.'
			PlayerStats.quest(2, 'Harvesting Wheat I', 'Cut 200 wheat with your sword.')

	else:
		text = 'Thanks for harvesting my wheat for me!'
		has_quest = false

func _process(delta: float) -> void:
	if 2 in PlayerStats.quests_completed:
		text = 'Thanks for harvesting my wheat for me!'
		has_quest = false
