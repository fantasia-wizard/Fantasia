extends "res://NPC/Npc.gd"

func _ready() -> void:
# warning-ignore:return_value_discarded
	connect('text_show', self, '_on_show_text')

func _on_show_text() -> void:
	if not 2 in PlayerStats.quests_completed:
		text = 'I have a quest for you!  Can you go harvest 40 wheat from my field?  Just cut it with your sword.'
		PlayerStats.quest(2, 'Harvesting Wheat', 'Cut 40 wheat with your sword.')
	else:
		text = 'Thanks for harvesting my wheat for me!'
