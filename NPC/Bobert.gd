extends "res://NPC/Npc.gd"

func text_show():
	if not 1 in PlayerStats.quests_completed:
		if PlayerStats.quest_id == 1 and PlayerStats.has_quest:
			text = 'Go slay 10 rats!'
		else:
			text = 'I have a quest for you!  Can you go slay 10 rats?'
			PlayerStats.quest(1, 'Rat Slayer II', 'Slay 10 rats')
	else:
		text = 'Great job slaying rats!'
		has_quest = false

func _process(delta: float) -> void:
	if 1 in PlayerStats.quests_completed:
		text = 'Thanks for killing rats for me!'
		has_quest = false
