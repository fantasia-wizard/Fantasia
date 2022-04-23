extends "res://NPC/Npc.gd"

func _ready() -> void:
# warning-ignore:return_value_discarded
	connect('text_show', self, '_on_show_text')

func _on_show_text() -> void:
	if not 0 in PlayerStats.quests_completed:
		if PlayerStats.quest_id == 0 and PlayerStats.has_quest:
			text = 'Go slay 1 rat!  To check your quest progress, press ESC or Triangle/Y on a controller, then click \'Quests\' at the top.'
		else:
			text = 'I have a quest for you!  Can you go kill a rat?  To check your quest progress, press ESC or Triangle/Y on a controller, then click \'Quests\' at the top.'
			PlayerStats.quest(5, 'Tutorial Rat Slayer', 'Slay a rat')

	else:
		text = 'Great job slaying rats! Remember, to check your quest progress, press ESC or Triangle/Y on a controller, then click \'Quests\' at the top.'
