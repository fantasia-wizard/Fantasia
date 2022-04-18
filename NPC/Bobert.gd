extends "res://NPC/Npc.gd"

func _ready() -> void:
# warning-ignore:return_value_discarded
	connect('text_show', self, '_on_show_text')

func _on_show_text() -> void:
	if not 0 in PlayerStats.quests_completed:
		text = 'I have a quest for you!  Can you go into the forest and slay 5 rats?'
		PlayerStats.quest(0, 'Rat Slayer I', 'Slay 5 rats')
	else:
		text = 'Thanks for harvesting my wheat for me!'
