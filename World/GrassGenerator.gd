tool
extends Node2D

var grass = preload('res://World/Grass.tscn')
var grass_locations = []

func _enter_tree() -> void:
	grass_locations.append(Vector2.ZERO)
	for _x in range(0, 10):
		var new_grass = grass.instance()
		add_child(new_grass)
		while true:
			var _found = true
			var location = grass_locations[randi() %grass_locations.size() - 1] + Vector2(rand_range(-10, 10), rand_range(-10, 10))
			for x in grass_locations:
				if x.distance_to(location) < 7:
					_found = false
			if _found:
				new_grass.global_position = location
				grass_locations.append(location)
				break
