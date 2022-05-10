extends "res://NPC/Npc.gd"

func text_show():
	if not 0 in PlayerStats.quests_completed:
		if PlayerStats.quest_id == 0 and PlayerStats.has_quest:
			text = 'Go slay 5 rats!  To check your quest progress, press ESC or Triangle/Y on a controller, then click \'Quests\''
		else:
			text = 'I have a quest for you!  Can you go into the forest and slay 5 rats?'
			PlayerStats.quest(0, 'Rat Slayer I', 'Slay 5 rats')

	else:
		text = 'Great job slaying rats! Remember, to check your quest progress, press ESC or Triangle/Y on a controller, then click \'Quests\''
		has_quest = false


func _process(delta: float) -> void:
	if 0 in PlayerStats.quests_completed:
		text = 'Thanks for harvesting my wheat for me!'
		has_quest = false
