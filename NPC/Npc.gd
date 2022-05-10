extends StaticBody2D

export var text = 'Hello World';

onready var detection = $Area2D
onready var label = $CanvasLayer/Label
signal text_show

var has_quest = true
var exclamation = preload('res://NPC/HasQuest.tscn')
var exclamation_node = null
var speaking = false

func _ready() -> void:
# warning-ignore:return_value_discarded
	connect('text_show', self, 'text_show')
	if has_quest:
		exclamation_node = exclamation.instance()
		add_child(exclamation_node)
		exclamation_node.global_position = global_position + Vector2(0, -35)

func display_text():
	emit_signal('text_show')
	speaking = true
	get_tree().paused = true
	label.visible = true

func hide_text():
	speaking = false
	get_tree().paused = false
	label.visible = false

func _process(_delta):
	if not has_quest and not str(get_node_or_null('Exclamation')) == '[Object:null]':  #check if there is an exclamation mark over his head and if he has no quest for the player.  If no such node exists, get_node_or_null(), when converted to a string returns [Object:null]
		get_node('Exclamation').queue_free()
	label.text = text
	if Input.is_action_just_pressed('ui_accept'):
		hide_text()
	if get_tree().paused == false:
		hide_text()

func _on_Area2D_area_exited(_area):
	hide_text()


func _on_Area2D_area_entered(_area):
	display_text()

