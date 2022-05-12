extends Node

enum{ #states
	WORLD
	BOSS
	MENU
}

var state = WORLD setget set_state

var overwold_list = [2, 3, 4, 5, 6]
var boss_list = [7, 8]
var menu_list = [0, 1]

func _ready() -> void:
	for x in get_children():
		x.connect('finished', self, 'music_finished', [x])
		x.volume_db = -10
	new_music()

func set_state(value):
	state = value

func _process(delta: float) -> void:
	pass

func music_finished(stream) -> void:
	new_music()
	stream.stop()

func new_music():
	var new_track = (randi() %5) + 2
	get_children()[new_track].play()
#	match state:
#		WORLD:
#			pass
#		MENU:
#			pass
#		BOSS:
#			pass
