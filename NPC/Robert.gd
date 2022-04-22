extends "res://NPC/Npc.gd"

func _ready() -> void:
# warning-ignore:return_value_discarded
	connect('text_show', self, '_on_show_text')

func _on_show_text() -> void:
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
