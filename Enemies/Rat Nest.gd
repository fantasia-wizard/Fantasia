extends YSort

onready var timer = $Timer
var rat = preload('res://Enemies/RatEmerge.tscn')

export var rats = 6


func _on_Timer_timeout():
	if get_child_count() <= rats:
		for _x in range(rand_range(0, 2)):
			var new_rat = rat.instance()
			add_child(new_rat)
			new_rat.global_position = global_position + Vector2(rand_range(-50, 50), rand_range(-50, 50))
			if new_rat.is_on_wall():
				new_rat.queue_free()
