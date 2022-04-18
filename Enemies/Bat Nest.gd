extends YSort

onready var timer = $Timer
var bat = preload('res://Enemies/BatAppear.tscn')

export var bats = 3

func _on_Timer_timeout():
	if get_child_count() <= bats:
		for _x in range(rand_range(0, 2)):
			var new_rat = bat.instance()
			add_child(new_rat)
			new_rat.global_position = global_position + Vector2(rand_range(-50, 50), rand_range(-50, 50))
			if new_rat.is_on_wall():
				new_rat.queue_free()
