extends Control

onready var health_bar = $'TabContainer/Player/Health/Health Bar'
onready var exp_bar = $'TabContainer/Player/Experience/Exp Bar'
onready var exit_button = $ExitButton
onready var tabs = $TabContainer
onready var timer = $Timer
onready var exp_label = $TabContainer/Player/Experience/ExpLabel
onready var skill_label = $TabContainer/Player/Skills/Label
onready var magic_level = $TabContainer/Player/Skills/Magic/Level
onready var speed_level = $TabContainer/Player/Skills/Speed/Level2
onready var strength_level = $TabContainer/Player/Skills/Strength/Level3
onready var quest_label = $TabContainer/Quests/Panel/Label
onready var quest_bar = $'TabContainer/Quests/Panel/Quest Bar'

var last_mouse_pos = Vector2.ZERO



func _ready():
	visible = false

func _process(_delta):
	quest_label.text = PlayerStats.quest_text
	magic_level.text = str('Level ' + str(PlayerStats.magic))
	strength_level.text = str('Level ' + str(PlayerStats.strength))
	speed_level.text = str('Level ' + str(PlayerStats.speed))
	skill_label.text = str('Skill Points: ' + str(PlayerStats.skill_points))
	if PlayerStats.exp_to_next_level != 1:
		exp_label.text = str('Level ' + str(PlayerStats.level) + ' XP ' + str(PlayerStats.experience) + ' / ' + str(PlayerStats.exp_to_next_level))
	else:
		exp_label.text = str('Level ' + str(PlayerStats.level) + ' XP ' + str(PlayerStats.experience) + ' / Max Level')
	health_bar.rect_size.x = PlayerStats.health_percent*132
	exp_bar.rect_size.x = PlayerStats.exp_percent*132
	if PlayerStats.has_quest:
		quest_bar.rect_size.x = PlayerStats.quest_progress_percent*132
	else:
		quest_bar.rect_size.x = 132
		quest_label.text = 'Quest Completed!'
	if get_tree().paused == false:
		visible = false
	if Input.is_action_just_pressed('ui_right') and visible:
		tab_right()
	if Input.is_action_just_pressed('ui_left') and visible:
		tab_left()
	if Input.is_action_just_pressed('inventory') and not get_tree().current_scene.name == 'Main Menu':
		visible = not visible
		get_tree().paused = visible
	if not visible:
		if get_viewport().get_mouse_position() != last_mouse_pos:
			last_mouse_pos = get_viewport().get_mouse_position()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			timer.start(1)
		elif timer.time_left == 0:
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func tab_right():
	if tabs.get_tab_count()-1 > tabs.current_tab:
		tabs.current_tab += 1
	else:
		tabs.current_tab = 0
func tab_left():
	if tabs.current_tab > 0:
		tabs.current_tab -= 1
	else:
		tabs.current_tab = tabs.get_tab_count()-1
func _on_Button_pressed():
	visible = not visible
	get_tree().paused = visible



func _on_MainMenu_pressed():
	$MainMenuConfirm.popup_centered()


func _on_MainMenuConfirm_confirmed():
	visible = not visible
	get_tree().paused = visible
	PlayerStats.load_game()
# warning-ignore:return_value_discarded
	get_tree().change_scene('res://UI/Main Menu.tscn')


func _on_ToHome_pressed():
	$HomeConfirm.popup_centered()


func _on_HomeConfirm_confirmed():
	visible = not visible
	get_tree().paused = visible
	PlayerStats.load_game()
	PlayerStats.start_location = Vector2(150, 100)
# warning-ignore:return_value_discarded
	get_tree().change_scene('res://Buildings/PlayerHouse.tscn')


func _on_Strength2_pressed():
	if PlayerStats.skill_points > 0:
		PlayerStats.skill_points -= 1
		PlayerStats.strength += 1

func _on_Speed2_pressed():
	if PlayerStats.skill_points > 0:
		PlayerStats.skill_points -= 1
		PlayerStats.speed += 1

func _on_Magic2_pressed():
	if PlayerStats.skill_points > 0:
		PlayerStats.skill_points -= 1
		PlayerStats.magic += 1
