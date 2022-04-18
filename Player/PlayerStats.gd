extends Node

enum{ #spells
	EXPLODE
	SHIELD
}
enum{ #quests
	RAT
	BAT
	WHEAT
	BOSS
}

onready var Healtimer = $HealTimer
onready var StaminaTimer = $StaminaTimer
onready var label = $CanvasLayer/Label
var max_health = 6.0 setget set_max_health
var health = max_health setget set_health
var health_percent = 1.0
var hearts = null
var start_location = Vector2.ZERO
var experience = 0;
var exp_to_next_level = 25;
var exp_percent = 0;
var regen_speed = 1.0
var max_stamina = 100.0
var stamina = max_stamina setget set_stamina
var stamina_percent = 100.0
var velocity = Vector2.ZERO
var hearts_collected = []
var level = 1
var level_exp = [0, 50, 75, 100, 250, 500, 1000, 1500, 2000, 3000, 6000, 12000, 15000, 20000, 30000, 50000, 65000, 80000, 90000, 100000, 1]
var level_health = [0, 0, 0, 1, 1, 1, 2, 2, 4, 4, 6, 8, 9, 10, 12, 13, 14, 15, 16, 17, 18, 20]
var level_skill = [0, 0, 1, 0, 0, 1, 0, 1, 1, 1, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 2]
var quest_val_list = [5, 10, 60, 1]
var quest_type_list = [RAT, RAT, WHEAT, BOSS]
var quest_xp_list= [25, 75, 200, 500]
var extra_hearts = 0
var max_level = level_exp.size()
var selected_spell = EXPLODE
var skill_points = 0
var location = Vector2.ZERO
var strength = 0
var speed = 0
var magic = 0
var has_quest = false
var quest_type = RAT
var quest_id = 0
var quest_text = 'No Quest'
var current_quest_progress = 0 setget set_quest_progress
var quest_progress_percent = 0
var rats_killed = 0 setget set_rats_killed
var bats_killed = 0 setget set_bats_killed
var wheat_harvested = 0 setget set_wheat_harvested
var bosses_killed = 0 setget set_bosses_killed
var played = false
var loading = false
var quests_completed = []
var touch_controls = OS.has_touchscreen_ui_hint()
var tutorials_completed = []
var achievements = []
var unhandled_achievement = false
var remove_achievement = false
var running = false

func _ready():
	label.visible = false

func save():
	var save_dict = {
		'wheat_harvested' : wheat_harvested,
		'tutorials_completed' : tutorials_completed,
		'touch_controls' : touch_controls,
		'magic' : magic,
		'speed' : speed,
		'strength' : strength,
		'hearts_collected' : hearts_collected,
		'skill_points' : skill_points,
		'level' : level,
		'extra_hearts' : extra_hearts,
		'selected_spell' : selected_spell,
		'played' : played,
		'max_health' : max_health,
		'health' : health,
		'experience' : experience,
		'exp_to_next_level' : exp_to_next_level,
		'regen_speed' : regen_speed,
		'max_stamina' : max_stamina,
		'stamina' : stamina,
		'quest_type' : quest_type,
		'quest_id' : quest_id,
		'quest_text' : quest_text,
		'has_quest' : has_quest,
		'current_quest_progress' : current_quest_progress,
		'quest_progress_percent' : quest_progress_percent,
		'rats_killed' : rats_killed,
		'bats_killed' : bats_killed,
		'quests_completed' : quests_completed,
		'achievements' : achievements
		}
	return save_dict

func get_variable(name):
	return save().get(name)

func load_game():
	loading = true
	var save_game = File.new()
	if not save_game.file_exists('user://savegame.save'):
		return false
	save_game.open('user://savegame.save', File.READ)
	while save_game.get_position() < save_game.get_len():
		var data = parse_json(save_game.get_line())
		for i in data.keys():
			set(i, data[i])
	save_game.close()
	health = max_health
	loading = false

func reset():
	has_quest = false
	wheat_harvested = 0
	level = 1
	played = false
	max_health = 6.0
	hearts_collected = []
	extra_hearts = 0
	health = max_health
	hearts = null
	experience = 0;
	exp_to_next_level = 25;
	regen_speed = 1.0
	max_stamina = 100.0
	stamina = max_stamina
	bats_killed = 0
	rats_killed = 0
	quest_progress_percent = 0
	current_quest_progress = 0
	quest_id = 0
	quest_type = RAT
	has_quest = true
	magic = 0
	speed = 0
	strength = 0
	save_game()
	played = false
	quests_completed = []
	touch_controls = false
	tutorials_completed = []
	achievements = []
	touch_controls = OS.has_touchscreen_ui_hint()

func save_game():
	if get_tree().current_scene.name != 'Main Menu':
		played = true
	else:
		played = false
	var save_game = File.new()
	save_game.open('user://savegame.save', File.WRITE)
	var data = save()
	save_game.store_line(to_json(data))
	save_game.close()
	label.visible = true
	$TextTimer.start(1)

func set_stamina(value):
	if velocity:
		stamina = value
		StaminaTimer.start(1)

func set_max_health(value):
	max_health = float(value)
	if health > max_health:
		health = max_health

func set_health(value):
	health = clamp(float(value), 0.0, max_health)
	if not health == max_health:
		Healtimer.start(2)

func _process(_delta):
	if Input.is_action_just_pressed('ui_accept'):
		experience += exp_to_next_level
	if unhandled_achievement:
		if $CanvasLayer/Achievement.rect_position.y < 2:
			$CanvasLayer/Achievement.rect_position.y += 2
		else:
			$AchievementTimer.start(4)
			set_deferred('unhandled_achievement', false)
	if remove_achievement:
		if $CanvasLayer/Achievement.rect_position.y > -55:
			$CanvasLayer/Achievement.rect_position.y -=2
		else:
			set_deferred('remove_achievement', false)
	quest_type = quest_type_list[quest_id]
	OS.min_window_size.y = OS.window_size.x/2.0
	OS.min_window_size.x = OS.window_size.y/1.0
	OS.set_max_window_size(Vector2(OS.window_size.y*2.0, OS.window_size.x))
	stamina = clamp(stamina, 0.0, max_stamina)
	stamina_percent = stamina/max_stamina
	stamina_percent = clamp(stamina_percent, 0.0, 1.0)
	if level_exp[level] != 1:
		exp_percent = experience/exp_to_next_level
	else:
		exp_percent = 1
	health_percent = health/max_health
	quest_progress_percent = current_quest_progress/quest_val_list[quest_id]
	if health < max_health and Healtimer.time_left == 0:
		Healtimer.start(2)

	if experience >= exp_to_next_level and level < 20:
		experience -= exp_to_next_level
		skill_points += level_skill[level]
		level += 1
		var extra_text = ' '
		if level == 3:
				extra_text = 'You leveled up!  You also earned a skill point.  In the menu, you can spend it to level up you Magic, Strength, or Speed'
		achievement('Level ' + str(level), extra_text, 'Level Up!')
	exp_to_next_level = level_exp[level]
	max_health = 6.0 + extra_hearts + level_health[level]
	if has_quest:
		if quest_type == RAT:
			quest_text = str('Kill ' + str(quest_val_list[quest_id]) + ' rats.')
		elif quest_type == BAT:
			quest_text = str('Kill ' + str(quest_val_list[quest_id]) + ' bats.')
		elif quest_type == WHEAT:
			quest_text = str('Harvest ' + str(quest_val_list[quest_id]) + ' wheat.')
	else:
		quest_text = 'No Quest'
		current_quest_progress = 0

func set_quest_progress(value):
	current_quest_progress = value
	if value >= quest_val_list[quest_id]:
		has_quest = false
		if not loading:
			experience += quest_xp_list[quest_id]
			quests_completed.append(quest_id)
			achievement('Quest Completed', 'Gained ' + str(quest_xp_list[quest_id]) + ' EXP', 'Quest Completed!')

func set_rats_killed(value):
	var new_value = value - rats_killed
	rats_killed += new_value
	if quest_type == RAT and has_quest and not loading:
		self.current_quest_progress += new_value

func set_bats_killed(value):
	var new_value = value - bats_killed
	bats_killed += new_value
	if quest_type == BAT and has_quest and not loading:
		self.current_quest_progress += new_value

func set_wheat_harvested(value):
	var new_value = value - wheat_harvested
	wheat_harvested += new_value
	if quest_type == WHEAT and has_quest and not loading:
		self.current_quest_progress += new_value

func set_bosses_killed(value):
	var new_value = value - wheat_harvested
	bosses_killed += new_value
	if quest_type == BOSS and has_quest and not loading:
		self.current_quest_progress += new_value

func _on_StaminaTimer_timeout():
	if velocity:
		stamina += 0.3*(speed+1)
	else:
		stamina += 0.5*(speed+1)
	StaminaTimer.start(0.01)


func _on_HealTimer_timeout():
	if stamina > 25:
		self.health += regen_speed
	if health < max_health:
		Healtimer.start(2)



func _on_TextTimer_timeout():
	label.visible = false

func achievement(text: String, description: String, _title: String):
	if text in achievements and _title == 'Acheivement':
		return
	elif _title == 'Acheivement':
		achievements.append(text)
	if _title != 'Acheivement':
		$CanvasLayer/Achievement/Title.text = _title
	else:
		$CanvasLayer/Achievement/Title.text = 'Achievement Recieved!'
	$CanvasLayer/Achievement.text = text
	$CanvasLayer/Achievement/Description.text = description
	$CanvasLayer/Achievement.rect_position.y = -55
	unhandled_achievement = true
	remove_achievement = false

func _on_AchievementTimer_timeout() -> void:
	remove_achievement = true

func quest(id: int, name: String, desc: String):
	if id in quests_completed:
		achievement('You already finished this quest!', 'You cannot take a quest you already completed.', 'Cannot take this quest')
		return false
	if not has_quest:
		quest_id = id
		achievement(name, desc, 'New Quest!')
		has_quest = true
		return true
	else:
		achievement('You already have a quest!', 'You cannot take a new quest until you finish your current quest.', 'Cannot take new quest')
		return false
