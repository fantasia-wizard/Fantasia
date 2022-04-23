extends "res://NPC/Npc.gd"

func _ready() -> void:
# warning-ignore:return_value_discarded
	connect('text_show', self, '_on_show_text')

func _on_show_text() -> void:
	if not 1 in PlayerStats.quests_completed:
		if PlayerStats.quest_id == 1 and PlayerStats.has_quest:
			text = 'Go slay 10 rats!'
		else:
			text = 'I have a quest for you!  Can you go slay 10 rats?'
			PlayerStats.quest(1, 'Rat Slayer II', 'Slay 10 rats')
	else:
		text = 'Great job slaying rats!'
