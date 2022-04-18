extends Sprite

var grass_break = preload('res://World/GrassBreak.tscn')
var grass_burn = preload('res://World/GrassBurn.tscn')
var scorch_mark = preload('res://Environment Effects/Scorch.tscn')
var rat = preload('res://Enemies/RatEmerge.tscn')
var heart = preload('res://Objects/Heart.tscn')

var colliding = false

func _ready():
	flip_h = cos(global_position.x + global_position.y) > 0
func die():
	var effect = grass_break.instance()
	get_parent().add_child(effect)
	effect.flip_h = flip_h
	effect.global_position = global_position
	if not colliding:
		match(randi() %20):
			0:
				var new_rat = rat.instance()
				get_parent().add_child(new_rat)
				new_rat.global_position = global_position
			1:
				var new_rat = rat.instance()
				get_parent().add_child(new_rat)
				new_rat.global_position = global_position
			2:
				var new_rat = rat.instance()
				get_parent().add_child(new_rat)
				new_rat.global_position = global_position
			3:
				var new_heart = heart.instance()
				get_parent().add_child(new_heart)
				new_heart.global_position = global_position

func explode():
	var scorch = scorch_mark.instance()
	get_parent().add_child(scorch)
	scorch.global_position = self.global_position
	var effect = grass_burn.instance()
	get_parent().add_child(effect)
	effect.flip_h = flip_h
	effect.global_position = global_position

func _on_Hitbox_area_entered(area):
	visible = false
	$Hitbox/CollisionShape2D.call('queue_free')
	if area.name == 'Explosion':
		call_deferred('explode')
	else:
		call_deferred('die')

func _on_Hit_Sound_finished():
	$'Hitbox/Hit Sound'.queue_free()
	queue_free()


func _on_Area2D_area_entered(area):
	colliding = true
